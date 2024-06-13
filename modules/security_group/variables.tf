variable "namespace" {
  description = "The namespace of the environment for the security groups, used as the prefix for the VPC security group names, e.g. `acme-web-staging`"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
