locals {
  app_name  = "devops-ic"
  region    = "ap-southeast-1"
  namespace = "${local.app_name}-${var.environment}"
}
