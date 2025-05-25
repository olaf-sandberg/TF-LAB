output "portfolio_id" {
  value = aws_servicecatalog_portfolio.portfolio.id
}

output "product_id" {
  value = aws_servicecatalog_product.product.id
}

output "product_template_url" {
  value = aws_s3_object.cf_template.url
}

output "bucket_name" {
  value = aws_s3_bucket.sc_templates.bucket
}
