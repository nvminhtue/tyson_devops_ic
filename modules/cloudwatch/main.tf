resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.namespace}-log-group"
  retention_in_days = local.retention_in_days
}
