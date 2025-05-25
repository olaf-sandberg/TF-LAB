variable "region" {
  default = "eu-central-1"
}

variable "portfolio_name" {
  default = "TF EC2 Portfolio"
}

variable "product_name" {
  default = "EC2 Public IP Product"
}

variable "template_url" {
  description = "The full HTTPS URL of the CloudFormation template"
  type        = string
}

variable "launch_role_arn" {
  description = "IAM role ARN used to launch the product"
  type        = string
}

variable "launch_principal_arn" {
  description = "IAM principal (user, group, or role) allowed to launch the product"
  type        = string
}
