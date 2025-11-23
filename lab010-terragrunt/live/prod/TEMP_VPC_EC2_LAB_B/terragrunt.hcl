include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/TEMP_VPC_EC2_LAB_MODULE"
}

inputs = {
  region         = "us-east-1"
  vpc_cidr       = "10.20.0.0/16"
  public_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnets = ["10.20.11.0/24", "10.20.12.0/24"]
  azs            = ["us-east-1a", "us-east-1b"]
}
