provider "aws" {
  region = var.region
}

module "network" {
  source              = "./modules/network"
  project_prefix      = var.project_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.project_prefix}-alb-sg"
  description = "Allow HTTP"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_prefix}-alb-sg"
  }
}

module "alb" {
  source               = "./modules/alb"
  project_prefix       = var.project_prefix
  vpc_id               = module.network.vpc_id
  public_subnet_ids    = module.network.public_subnet_ids
  alb_security_group_id = aws_security_group.alb_sg.id
}

module "ecs" {
  source             = "./modules/ecs"
  project_prefix     = var.project_prefix
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  container_image    = var.container_image
}
