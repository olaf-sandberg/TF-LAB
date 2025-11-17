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
  alias = "central"
}

provider "aws" {
  region = "eu-west-1"
  alias = "west"
}

###test

resource "aws_instance" "ec2-olo" {
  provider = aws.central
  count = 3
  subnet_id = "subnet-0c66c7cba1beba439"
  ami = "ami-04d20b438ef4a018a"
  instance_type = "t2.nano"

tags = {
  Name = "EC2-${count.index}"
  project = "${local.project}"
}
  
}


/*
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "olotestbucket-${count.index}"
  count = 3
  tags = {
    Name = "Bucket-${count.index}"
    project = local.dmz
  }

  
}



resource "aws_instance" "this" {
  count = 3
  provider = aws.central
  ami = "ami-xxxxxxx"
  subnet_id = "sub-yyyyyyy"
  instance_type = "t3.micro"

tags = {
  Name = "EC2-${index.count}"
}

*/