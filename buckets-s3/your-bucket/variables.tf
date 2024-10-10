variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "bucket_tag" {
  description = "Tag do bucket S3"
  type        = string
}

variable "cloudfront_alternate_domain" {
  description = "Domínio alternativo para a distribuição CloudFront"
  type        = string
}

variable "cloudfront_description" {
  description = "Descrição da distribuição CloudFront"
  type        = string
}
