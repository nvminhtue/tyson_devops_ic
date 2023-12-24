locals {
  app_name           = "devops_ic"
  region             = "ap-southeast-1"
  namespace          = "${local.app_name}-${var.environment}"
  rds_instance_class = "db.t3.micro"
}
