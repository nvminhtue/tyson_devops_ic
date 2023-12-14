resource "aws_ssm_parameter" "secrets_manager" {
  for_each = var.secrets

  name = "/${var.env_namespace}/${each.key}"
  type = "String"
  value = each.value
}
