resource "aws_ssm_parameter" "secret_parameters" {
  for_each = var.secrets

  name  = "/${var.env_namespace}/${each.key}"
  type  = "String"
  value = each.value
}
