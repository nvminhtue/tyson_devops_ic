variable "namespace" {
  description = "The namespace of the environment, e.g. `acme-web-staging`"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to be used by the RDS cluster"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "username" {
  description = "The DB master username: 1–16 alphanumeric characters and underscores, first character must be a letter, can't be a word reserved by the database engine"
  type        = string
}

variable "password" {
  description = "RDS password. Some special chars might result in a wrong encoding of the DATABASE_URL"
  type        = string
  sensitive   = true
}
