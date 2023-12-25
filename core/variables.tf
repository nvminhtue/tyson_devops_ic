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
}

variable "rds_autoscaling_min_capacity" {
  description = "Minimum number of RDS read replicas when autoscaling is enabled"
  type        = number
}

variable "rds_autoscaling_max_capacity" {
  description = "Maximum number of RDS read replicas when autoscaling is enabled"
  type        = number
}
