variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID for EC2"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, prod, shared)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
}