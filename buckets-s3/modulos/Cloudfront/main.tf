# Configuração da Distribuição CloudFront
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.bucket_domain_name  # Usando o domínio da bucket passada como variável
    origin_id   = var.bucket_name         # ID da bucket passada como variável

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id  # Usando OAC

    custom_header {
      name  = "Access-Control-Allow-Origin"
      value = "*"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.cloudfront_alternate_domain  # Comentário atualizado
  default_root_object = ""

  aliases = [var.cloudfront_alternate_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name  # Referência à bucket passada como variável

    viewer_protocol_policy = "allow-all"

    compress               = true
    cache_policy_id         = "658327ea-f89d-4fab-a63d-7e88639e58f6"  # CachingOptimized
    origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"  # CORS-S3Origin
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn  # Certificado atualizado gerado pelo ACM
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  logging_config {
    bucket          = "dnc-logs.s3.amazonaws.com"
    prefix          = "CF/S3/${var.cloudfront_alternate_domain}"  # Atualizado com o prefixo correto
    include_cookies = false
  }

  price_class = "PriceClass_100"
  http_version = "http2and3"
}

# Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                             = "test-nic-23"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Certificado ACM
resource "aws_acm_certificate" "cert" {
  domain_name       = var.cloudfront_alternate_domain  # Nome de domínio alternativo
  validation_method = "DNS"

  tags = {
    Name = "CloudFront Certificate for ${var.cloudfront_alternate_domain}"
  }
}

# Validação do certificado ACM
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : aws_route53_record.cert_validation[dvo.domain_name].fqdn
  ]
}

# Busca pela zona hospedada no Route 53
data "aws_route53_zone" "main" {
  name         = "[your-domain]"  # Nome da zona hospedada
  private_zone = false
}

# Registro CNAME para validação do certificado ACM
resource "aws_route53_record" "cert_validation" {
  for_each = { for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => dvo }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  ttl     = 300
  records = [each.value.resource_record_value]
}

# Registro CNAME para o CloudFront
resource "aws_route53_record" "cloudfront_cname" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.cloudfront_alternate_domain  # Nome do registro CNAME
  type    = "CNAME"
  ttl     = 300

  records = [aws_cloudfront_distribution.cdn.domain_name]  # Domínio do CloudFront
}
