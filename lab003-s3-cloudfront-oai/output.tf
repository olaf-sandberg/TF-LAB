output "cloudfront_domain" {
  description = "CloudFront URL to access the website"
  value       = aws_cloudfront_distribution.lab003.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.lab003.id
}
