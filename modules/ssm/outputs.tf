output "secrets_variables" {
  description = "The formatted secrets for the ECS task definition"
  value       = local.secrets_variables
}

output "secret_arns" {
  description = "The list of secret ARNs for ECS task execution role granting access"
  value       = local.secret_arns
}
