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

variable "iam_admin_emails" {
  description = "List of IAM admin emails"
  type        = list(string)
}

variable "iam_developer_emails" {
  description = "List of IAM developer emails"
  type        = list(string)
}

variable "iam_bot_emails" {
  description = "List of IAM bot emails"
  type        = list(string)
}
