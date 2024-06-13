module "vpc" {
  source = "../modules/vpc"

  namespace = local.namespace
}

module "ssm" {
  source = "../modules/ssm"

  env_namespace = local.namespace
  secrets = {
    secret_key_base = var.secret_key_base
  }
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  namespace = local.namespace
}

module "rds" {
  source = "../modules/rds"

  env_namespace = local.namespace

  vpc_security_group_ids = module.sercurity_group.vpc_security_group_ids
  vpc_id                 = module.vpc.vpc_id

  subnets = module.vpc.private_subnet_ids

  instance_class = local.rds_instance_class
  database_name  = var.rds_database_name
  username       = var.rds_username
  password       = var.rds_password

  autoscaling_min_capacity = var.rds_autoscaling_min_capacity
  autoscaling_max_capacity = var.rds_autoscaling_max_capacity
}
