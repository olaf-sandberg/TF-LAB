include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  segment_config = read_terragrunt_config(find_in_parent_folders("segment.hcl"))
}

terraform {
  source = "../../../modules/TEMP_VPC_EC2_LAB_MODULE"
}

inputs = merge(
  local.segment_config.inputs,
  {
    vpc_name        = "VPC_B"
    region          = "eu-west-1"

    vpc_cidr        = "10.10.0.0/16"

    public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnets = ["10.10.11.0/24", "10.10.12.0/24"]

    azs             = ["eu-west-1a", "eu-west-1b"]
  }
)
