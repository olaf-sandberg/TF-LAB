terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.5"
    }
  }
}



resource "aws_instance" "ec2-1" {
  instance_type = var.ec2_type
  ami = var.ami
  subnet_id = var.subnet_id

  tags = {
    name = "EC2-${local.name}"
  }
}