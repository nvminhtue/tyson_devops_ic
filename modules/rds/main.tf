module "rds" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.0.0"

  name = "${var.namespace}-aurora-db"

  engine         = "aurora-postgresql"
  engine_version = 15.3

  vpc_id                 = var.vpc_id
  subnets                = var.subnets
  vpc_security_group_ids = var.vpc_security_group_ids

  instance_class = var.instance_class
  instances = {
    one = {}
  }

  autoscaling_enabled      = true
  autoscaling_min_capacity = local.autoscaling_min_capacity
  autoscaling_max_capacity = local.autoscaling_max_capacity

  create_monitoring_role = false
  create_security_group  = false

  publicly_accessible = false

  database_name       = var.database_name
  master_username     = var.username
  master_password     = var.password
  port                = 5432
  deletion_protection = true

  enabled_cloudwatch_logs_exports = ["postgresql"]
}
