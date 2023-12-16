locals {
  # Create a list of secret ARNs for ECS task execution role granting access
  secret_arns = [for secret in aws_ssm_parameter.secret_parameters : secret.arn]

  # Create a secret names list
  secret_names = keys(var.secrets)

  # Create a map {secret_name: secret_arn}
  secret_arn_map = zipmap(local.secret_names, local.secret_arns)

  # Create the formatted secrets for the ECS task definition
  secrets_variables = [for secret_key, secret_arn in local.secret_arn_map :
    tomap({
      "name"      = upper(secret_key),
      "valueFrom" = secret_arn
    })
  ]
}
