variable "project_prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for ECS service security group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Target group ARN for ECS service"
  type        = string
}

variable "container_image" {
  description = "Container image to run (e.g., nginx)"
  type        = string
}
