output "cdn_arn" {
  description = "O ARN da distribuição CloudFront"
  value       = aws_cloudfront_distribution.cdn.arn
}

