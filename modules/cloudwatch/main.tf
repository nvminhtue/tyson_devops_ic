resource "aws_cloudwatch_log_group" "this" {
  name              = "devops-ic-${var.env_namespace}-log-group"
  retention_in_days = local.retention_in_days
}
