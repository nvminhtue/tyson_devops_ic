variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
}

variable "owner" {
  description = "The owner of the infrastructure, used to tag the resources, e.g. `acme-web`"
  type        = string
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "secret_key_base" {
  description = "The secret key base for the application"
  type        = string
  sensitive   = true
}

variable "database_host" {
  description = "RDS database host"
  type        = string
  sensitive   = true
}

variable "database_port" {
  description = "RDS database port"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "RDS database name"
  type        = string
  sensitive   = true
}

variable "database_username" {
  description = "RDS database username"
  type        = string
  sensitive   = true
}

variable "database_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}

variable "rds_database_name" {
  description = "RDS database name"
  type        = string
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "bastion_instance_desired_count" {
  description = "The desired number of the bastion instance"
  default     = 1
}

variable "bastion_max_instance_count" {
  description = "The maximum number of the instance"
  default     = 1
}

variable "bastion_min_instance_count" {
  description = "The minimum number of the instance"
  default     = 1
}

variable "redis_host" {
  description = "Redis host"
  type        = string
  sensitive   = true
}

variable "redis_port" {
  description = "Redis port"
  type        = string
  sensitive   = true
}
