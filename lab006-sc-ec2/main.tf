provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "sc_templates" {
  bucket = "lab006-sc-tf-bucket"
  force_destroy = true
}

resource "aws_s3_object" "cf_template" {
  bucket = aws_s3_bucket.sc_templates.id
  key    = "ec2-template.yaml"
  source = var.template_path
  etag   = filemd5(var.template_path)
}

resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = "EC2 Launch Portfolio via Terraform"
  provider_name = "Terraform"
}

resource "aws_servicecatalog_product" "product" {
  name  = var.product_name
  owner = "Terraform"
  type  = "CLOUD_FORMATION_TEMPLATE"
  provisioning_artifact_parameters {
    name         = "v1"
    description  = "Initial version"
    template_url = aws_s3_object.cf_template.url
    type         = "CLOUD_FORMATION_TEMPLATE"
  }
}

resource "aws_servicecatalog_portfolio_product_association" "assoc" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.product.id
}

resource "aws_servicecatalog_portfolio_principal_association" "permissions" {
  portfolio_id   = aws_servicecatalog_portfolio.portfolio.id
  principal_arn  = var.launch_principal_arn
  principal_type = "IAM"
}

resource "aws_servicecatalog_launch_constraint" "launch" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.product.id
  description  = "Use launch role"
  role_arn     = var.launch_role_arn
}
