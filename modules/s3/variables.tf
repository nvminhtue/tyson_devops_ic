variable "namespace" {
  description = "The namespace of the environment, e.g. `acme-web-staging`"
  type        = string
}

variable "expiration_in_days" {
  description = "The number of days to retain expired objects"
  type        = number
}
