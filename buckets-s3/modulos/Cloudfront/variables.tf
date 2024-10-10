variable "bucket_name" {
  description = "Nome do bucket"
  type        = string
}

variable "bucket_domain_name" {
  description = "O domínio do bucket S3"
  type        = string
}

variable "cloudfront_description" {
  description = "Descrição do CloudFront"
  type        = string
}

variable "cloudfront_alternate_domain" {
  description = "Nome alternativo do domínio para o CloudFront"
  type        = string
}
