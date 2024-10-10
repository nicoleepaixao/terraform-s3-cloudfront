variable "bucket_name" {
  description = "Nome do bucket"
  type        = string
}

variable "bucket_tag" {
  description = "Tag do bucket"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "O ARN da distribuição CloudFront para ser usado na política do bucket S3"
  type        = string
}