include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/TEMP_VPC_EC2_LAB_MODULE"
}

inputs = {
  name     = "lab-a"
  region   = "eu-central-1"
  vpc_cidr = "10.10.0.0/16"
}