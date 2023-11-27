variable "usernames" {
  description = "Desired names for IAM users"
  type        = list(string)
}

variable "has_login" {
  description = "Whether to create IAM user login profile"
  type        = bool
  default     = true
}
