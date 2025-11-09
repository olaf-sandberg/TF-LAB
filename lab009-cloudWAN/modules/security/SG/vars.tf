variable "sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to associate with this Security Group"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g. dev, prod)"
  type        = string
}

variable "project" {
  description = "Project tag"
  type        = string
}