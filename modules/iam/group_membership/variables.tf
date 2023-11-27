variable "name" {
  description = "Name of the IAM group membership"
  type        = string
}

variable "group" {
  description = "Name of the IAM group to attach the users to"
  type        = string
}

variable "users" {
  description = "List of IAM users to associate with the group"
  type        = list(string)
}