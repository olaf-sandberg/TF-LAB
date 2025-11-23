locals {
  # global tags applied to all resources
  default_tags = {
    project     = "terragrunt-lab"
    environment = "lab"
    owner       = "olo"
  }
}

# all child folders inherit this
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = var.region
}
EOF
}

remote_state {
  backend = "s3"

  config = {
    bucket         = "smartbidit"
    key            = "./terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

# Global defaults
inputs = {
  environment = "live"
}