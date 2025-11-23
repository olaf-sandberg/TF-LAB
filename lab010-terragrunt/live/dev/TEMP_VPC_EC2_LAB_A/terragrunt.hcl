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
    vpc_name        = "VPC_A"
    region          = "eu-central-1"

    vpc_cidr        = "10.1.0.0/16"

    public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
    private_subnets = ["10.1.11.0/24", "10.1.12.0/24"]

    azs             = ["eu-central-1a", "eu-central-1b"]
  }
)
