terraform {


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }

}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "test1" {
  cidr_block = "192.168.0.0/16"

}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.test1.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Main"
  }
}

resource "aws_subnet" "main2" {
  vpc_id            = aws_vpc.test1.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Main"
  }
}