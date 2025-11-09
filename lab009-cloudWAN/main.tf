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

module "vpc_c" {
  source = "./modules/network/vpc"

  providers = {
    aws = aws.eu_west_1
  }

  region         = "eu-west-1"
  project        = "cloudwan-lab"
  cidr           = "10.100.0.0/16"
  public_subnets = ["10.100.0.0/24"]

  tags = {
    Environment = "shared"
    VPC         = "C"
  }
}


module "vpc_d" {
  source = "./modules/network/vpc"

  providers = {
    aws = aws.eu_west_2
  }

  region         = "eu-west-2"
  project        = "cloudwan-lab"
  cidr           = "192.168.0.0/24"
  public_subnets = ["192.168.0.0/25"]

  tags = {
    Environment = "dev"
    VPC         = "D"
  }
}


module "vpc_e" {
  source = "./modules/network/vpc"

  providers = {
    aws = aws.eu_west_2
  }

  region         = "eu-west-2"
  project        = "cloudwan-lab"
  cidr           = "192.168.1.0/24"
  public_subnets = ["192.168.1.0/25"]

  tags = {
    Environment = "prod"
    VPC         = "E"
  }
}





module "sg_central-1" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_central_1 }

  sg_name     = "sg-eu-1"
  vpc_id      = module.vpc_a.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}


module "sg_west-1" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_west_1 }

  sg_name     = "sg-west-1"
  vpc_id      = module.vpc_a.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}

module "sg_west-2" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_west_2 }

  sg_name     = "sg-west-2"
  vpc_id      = module.vpc_a.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}