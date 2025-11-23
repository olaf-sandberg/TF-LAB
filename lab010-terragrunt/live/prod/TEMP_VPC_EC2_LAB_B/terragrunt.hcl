include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/TEMP_VPC_EC2_LAB_MODULE"
}

inputs = {
  name     = "lab-b"
  region   = "us-east-1"
  vpc_cidr = "10.20.0.0/16"
}