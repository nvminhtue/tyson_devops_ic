variable "cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "namespace" {
  description = "Namespace of the VPC"
  type        = string
}
