terraform {
  cloud { 
    
    organization = "OLAFSANDBERG" 

    workspaces { 
      name = "tf_lab" 
    } 
  } 

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  alias = "eu"
  
}

resource "aws_instance" "ec2-1" {
  instance_type = var.ec2_type
  ami = var.ami
  subnet_id = var.subnet_id
  provider = aws.eu
  
}