variable "project_prefix" {
  default = "lab005-ecs-alb"
}

variable "region" {
  default = "eu-central-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "container_image" {
  default = "nginx:latest"
}
