terraform {
  backend "s3" {
    bucket         = "tfstate-lab008-hybridcloud"
    key            = "envs/eu-central-1/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}