variable "ami_id" {}

variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {}

variable "sg_pol_pub" {}

variable "public_subnets" {
  type = list(string)
}
variable "vpc_id" {}