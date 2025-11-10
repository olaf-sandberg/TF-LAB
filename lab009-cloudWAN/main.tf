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





module "sg_central_1a" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_central_1 }

  sg_name     = "sg_eu_1_a"
  vpc_id      = module.vpc_a.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}

module "sg_central_1b" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_central_1 }

  sg_name     = "sg_eu_1_b"
  vpc_id      = module.vpc_b.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}


module "sg_west_1c" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_west_1 }

  sg_name     = "sg_west_1_c"
  vpc_id      = module.vpc_c.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}

module "sg_west_2d" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_west_2 }

  sg_name     = "sg_west_2d"
  vpc_id      = module.vpc_d.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}

module "sg_west_2e" {
  source     = "./modules/security/SG"
  providers  = { aws = aws.eu_west_2 }

  sg_name     = "sg_west_2e"
  vpc_id      = module.vpc_e.vpc_id
  environment = "dev"
  project     = "cloudwan-lab"
}


# ---------- EC2 A (eu-central-1 / VPC A / DEV) ----------
module "ec2_a" {
  source    = "./modules/compute/ec2"
  providers = { aws = aws.eu_central_1 }

  instance_name = "ec2-a"
  instance_type = "t3.micro"
  ami_id        = "ami-04d20b438ef4a018a"
  subnet_id     = module.vpc_a.public_subnet_ids[0]
  sg_id         = module.sg_central_1a.sg_id
  key_name      = "cloudwan-key"
  environment   = "dev"
  project       = "cloudwan-lab"
}

# ---------- EC2 B (eu-central-1 / VPC B / PROD) ----------
module "ec2_b" {
  source    = "./modules/compute/ec2"
  providers = { aws = aws.eu_central_1 }

  instance_name = "ec2-b"
  instance_type = "t3.micro"
  ami_id        = "ami-04d20b438ef4a018a"
  subnet_id     = module.vpc_b.public_subnet_ids[0]
  sg_id         = module.sg_central_1b.sg_id
  key_name      = "cloudwan-key"
  environment   = "prod"
  project       = "cloudwan-lab"
}

# ---------- EC2 C (eu-west-1 / VPC C / SHARED) ----------
module "ec2_c" {
  source    = "./modules/compute/ec2"
  providers = { aws = aws.eu_west_1 }

  instance_name = "ec2-c"
  instance_type = "t3.micro"
  ami_id        = "ami-06297e16b71156b52"
  subnet_id     = module.vpc_c.public_subnet_ids[0]
  sg_id         = module.sg_west_1c.sg_id
  key_name      = "cloudwan-key"
  environment   = "shared"
  project       = "cloudwan-lab"
}

# ---------- EC2 D (eu-west-2 / VPC D / DEV) ----------
module "ec2_d" {
  source    = "./modules/compute/ec2"
  providers = { aws = aws.eu_west_2 }

  instance_name = "ec2-d"
  instance_type = "t3.micro"
  ami_id        = "ami-075599e9cc6e3190d"
  subnet_id     = module.vpc_d.public_subnet_ids[0]
  sg_id         = module.sg_west_2d.sg_id
  key_name      = "cloudwan-key"
  environment   = "dev"
  project       = "cloudwan-lab"
}

# ---------- EC2 E (eu-west-2 / VPC E / PROD) ----------
module "ec2_e" {
  source    = "./modules/compute/ec2"
  providers = { aws = aws.eu_west_2 }

  instance_name = "ec2-e"
  instance_type = "t3.micro"
  ami_id        = "ami-075599e9cc6e3190d"
  subnet_id     = module.vpc_e.public_subnet_ids[0]
  sg_id         = module.sg_west_2e.sg_id
  key_name      = "cloudwan-key"
  environment   = "prod"
  project       = "cloudwan-lab"
}
