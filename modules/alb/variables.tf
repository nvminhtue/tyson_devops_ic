variable "namespace" {
  description = "The namespace of the environment, e.g. `acme-web-staging`"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}
