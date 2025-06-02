module "launch_template" {
  source             = "./modules/launch_template"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_id  = var.sg_pol_pub
  name_prefix        = "lab006-lt-alb-asg"
}

module "alb" {
  source            = "./modules/alb"
  public_subnets    = var.public_subnets
  security_group_id = var.sg_pol_pub
  vpc_id            = var.vpc_id
  name_prefix       = "lab006-lt-alb-asg"
}

module "asg" {
  source             = "./modules/asg"
  public_subnets     = var.public_subnets
  launch_template_id = module.launch_template.launch_template_id
  target_group_arn   = module.alb.target_group_arn
  name_prefix        = "lab006-lt-alb-asg"
}
