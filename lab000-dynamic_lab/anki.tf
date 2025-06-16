terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.5.0" 
    }
  }
}

  provider "aws" {
    region = "eu-central-1"
    profile = "default"
    
  }

  resource "aws_instance" "ec2-1" {
    instance_type = "t3.micro"
    ami = "ami-04d20b438ef4a018a"
  }