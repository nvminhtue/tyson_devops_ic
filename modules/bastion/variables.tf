variable "namespace" {
  description = "The namespace with environment for the bastion instance"
  type        = string
}

variable "subnet_ids" {
  description = "The public setnet IsD for the instance"
  type        = list(string)
}

variable "instance_security_group_ids" {
  description = "The security group IDs for the instance"
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type"
  default     = "t3a.micro"
}

variable "instance_desired_count" {
  description = "The desired number of the instance"
  default     = 1
}

variable "max_instance_count" {
  description = "The maximum number of the instance"
  default     = 1
}

variable "min_instance_count" {
  description = "The minimum number of the instance"
  default     = 1
}

variable "ami_id" {
  description = "The AMI ID for the instance"
  default     = "ami-0012ef68c16acc6f4"
}
