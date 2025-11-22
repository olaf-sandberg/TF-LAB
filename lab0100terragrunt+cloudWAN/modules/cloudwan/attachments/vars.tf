variable "core_network_id" {}
variable "vpc_arn" {}
variable "subnet_arns" {
  type = list(string)
}
variable "segment_name" {}
variable "project" {}