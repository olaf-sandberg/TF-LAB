variable "launch_template_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "target_group_arn" {}
variable "name_prefix" {}