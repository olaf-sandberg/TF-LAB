module "vpc_a" {
  source = "./modules/network/vpc"

  providers = {
    aws = aws.eu_central_1
  }

  region         = "eu-central-1"
  project        = "cloudwan-lab"
  cidr           = "10.0.0.0/16"
  public_subnets = ["10.0.0.0/24"]

  tags = {
    Environment = "dev"
    VPC         = "A"
  }
}

module "vpc_b" {
  source = "./modules/network/vpc"

  providers = {
    aws = aws.eu_central_1
  }

  region         = "eu-central-1"
  project        = "cloudwan-lab"
  cidr           = "10.1.0.0/16"
  public_subnets = ["10.1.0.0/24"]

  tags = {
    Environment = "prod"
    VPC         = "B"
  }
}