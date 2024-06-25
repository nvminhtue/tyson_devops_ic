locals {
  app_name  = "devops-ic"
  region    = "ap-southeast-1"
  namespace = "${local.app_name}-${var.environment}"

  app_port          = 4000
  health_check_path = "/"
}
