module "vpc" {
  source = "../modules/vpc"

  namespace = local.namespace
}

module "ssm" {
  source = "../modules/ssm"

  namespace = local.namespace
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

  namespace = local.namespace

  vpc_security_group_ids = module.security_group.rds_security_groups_ids
  vpc_id                 = module.vpc.vpc_id

  subnets = module.vpc.private_subnets

  database_name = var.rds_database_name
  username      = var.rds_username
  password      = var.rds_password
}

module "security_group" {
  source = "../modules/security_group"

  namespace = local.namespace
  vpc_id    = module.vpc.vpc_id
}

module "s3" {
  source = "../modules/s3"

  namespace = local.namespace
}

module "alb" {
  source = "../modules/alb"

  vpc_id = module.vpc.vpc_id

  subnets_ids        = module.vpc.public_subnets
  security_group_ids = module.security_group.alb_security_groups_ids

  namespace = local.namespace
}
