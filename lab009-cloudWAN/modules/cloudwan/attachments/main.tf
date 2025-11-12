resource "aws_networkmanager_vpc_attachment" "this" {
  core_network_id = var.core_network_id
  subnet_arns     = var.subnet_arns
  vpc_arn         = var.vpc_arn
  tags = {
    Segment     = var.segment_name
    Project     = var.project
  }

  options {
    ipv6_support = "disable"
  }
}