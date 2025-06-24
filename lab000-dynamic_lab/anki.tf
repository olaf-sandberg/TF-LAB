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

resource "aws_instance" "ec2-olo" {
  subnet_id = "subnet-0c66c7cba1beba439"
  ami = "ami-04d20b438ef4a018a"
  instance_type = "t2.nano"

tags = {
  name = "${local.project}"
}
  
}