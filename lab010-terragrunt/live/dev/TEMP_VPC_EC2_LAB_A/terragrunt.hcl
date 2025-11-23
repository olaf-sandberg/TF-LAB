include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/TEMP_VPC_EC2_LAB_MODULE"
}

inputs = {
  region         = "eu-central-1"
  vpc_cidr       = "10.10.0.0/16"
  public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.11.0/24", "10.10.12.0/24"]
  azs            = ["eu-central-1a", "eu-central-1b"]
}