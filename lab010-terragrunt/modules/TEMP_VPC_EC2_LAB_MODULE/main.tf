terraform {
  backend "s3" {}
}


variable "vpc_cidr" {}
variable "region" {}
variable "name" {}
variable "global_tags" {}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.global_tags, { Name = "${var.name}-vpc" })
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
  availability_zone = "${var.region}a"

  tags = merge(var.global_tags, { Name = "${var.name}-subnet" })
}

resource "aws_instance" "ec2" {
  ami           = "ami-08d4ac5b634553e16" # Ubuntu 22.04 (eu-central-1)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet.id

  tags = merge(var.global_tags, { Name = "${var.name}-ec2" })
}

output "vpc_id" {
  value = aws_vpc.this.id
}