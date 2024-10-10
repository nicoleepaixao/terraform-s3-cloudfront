module "s3_bucket" {
  source = "../modulos/s3"

  bucket_name               = var.bucket_name
  bucket_tag                = var.bucket_tag
  cloudfront_distribution_arn = module.cloudfront.cdn_arn  # Passa o ARN do CloudFront para o S3
}

module "cloudfront" {
  source = "../modulos/cloudfront"

  bucket_name               = module.s3_bucket.bucket_name
  bucket_domain_name        = module.s3_bucket.bucket_domain_name
  cloudfront_alternate_domain = var.cloudfront_alternate_domain
  cloudfront_description    = var.cloudfront_description
}