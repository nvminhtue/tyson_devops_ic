locals {
  app_name                      = "devops-ic"
  region                        = "ap-southeast-1"
  namespace                     = "${local.app_name}-${var.environment}"
  rds_instance_class            = "db.t3.micro"
  s3_objects_expiration_in_days = 60
}
