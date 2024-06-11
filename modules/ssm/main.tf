resource "aws_ssm_parameter" "secret_parameters" {
  for_each = var.secrets

  name  = "/${var.env_namespace}/${each.key}-${random_string.service_secret_random_suffix.result}"
  type  = "String"
  value = each.value
}

resource "random_string" "service_secret_random_suffix" {
  length  = 6
  special = false
}
