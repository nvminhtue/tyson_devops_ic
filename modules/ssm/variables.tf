variable "namespace" {
  description = "The namespace of the environment, e.g. `acme-web-staging`"
  type        = string
}

variable "secrets" {
  description = "Map of secrets to store in SSM"
  type        = map(string)
  default     = {}
}
