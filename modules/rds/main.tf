# resource "aws_db_subnet_group" "this" {
#   name       = "${var.namespace}-aurora-db-subnet-group"
#   subnet_ids = var.subnets

#   tags = {
#     Name = "${var.namespace}-aurora-db-subnet-group"
#   }
# }

module "rds" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.9.0"

  name = "${var.namespace}-aurora-db"

  engine         = "aurora-postgresql"
  engine_version = 15.3

  vpc_id                 = var.vpc_id
  subnets                = var.subnets
  vpc_security_group_ids = var.vpc_security_group_ids

  create_db_subnet_group = true
  db_subnet_group_name = "${var.namespace}-aurora-db-subnet-group"

  instance_class = local.instance_class
  instances = {
    main = {}
  }

  autoscaling_enabled      = true
  autoscaling_min_capacity = local.autoscaling_min_capacity
  autoscaling_max_capacity = local.autoscaling_max_capacity

  create_monitoring_role = false
  create_security_group  = false
  storage_encrypted      = true

  publicly_accessible = false

  database_name       = var.database_name
  master_username     = var.username
  master_password     = var.password
  port                = 5432
  deletion_protection = true

  enabled_cloudwatch_logs_exports = ["postgresql"]
}
