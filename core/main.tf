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

  namespace                   = local.namespace
  vpc_id                      = module.vpc.vpc_id
  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  app_port                    = local.app_port
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

  namespace         = local.namespace
  app_port          = local.app_port
  health_check_path = local.health_check_path
}

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  namespace = local.namespace
}

module "ecs" {
  source = "../modules/ecs"

  namespace = local.namespace
  subnets   = module.vpc.private_subnets
  region    = local.region
  app_host  = module.alb.alb_dns_name
  app_port  = local.app_port

  ecs_cluster_id   = module.ecs_cluster.aws_ecs_cluster_attributes.id
  ecs_cluster_name = module.ecs_cluster.aws_ecs_cluster_attributes.name

  ecr_repo_name = local.current_ecs_config.ecr_repo_name
  ecr_tag       = local.current_ecs_config.ecr_tag

  security_groups      = module.security_group.alb_security_groups_ids
  alb_target_group_arn = module.alb.alb_target_group_arn

  aws_cloudwatch_log_group_name = module.cloudwatch.aws_cloudwatch_log_group_name

  desired_count                        = local.current_ecs_config.desired_count
  cpu                                  = local.current_ecs_config.task_cpu
  memory                               = local.current_ecs_config.task_memory
  deployment_maximum_percent           = local.current_ecs_config.deployment_maximum_percent
  deployment_minimum_healthy_percent   = local.current_ecs_config.deployment_minimum_healthy_percent
  max_instance_count                   = local.current_ecs_config.max_instance_count
  min_instance_count                   = local.current_ecs_config.min_instance_count
  autoscaling_target_memory_percentage = local.current_ecs_config.autoscaling_target_memory_percentage
  autoscaling_target_cpu_percentage    = local.current_ecs_config.autoscaling_target_cpu_percentage
  health_check_grace_period_seconds    = local.current_ecs_config.health_check_grace_period_seconds

  environment_variables = local.ecs_container_variables
  secrets_variables     = module.ssm.secrets_variables
  secrets_arns          = module.ssm.secret_arns
}

module "elasticache" {
  source = "../modules/elasticache"

  namespace          = local.namespace
  subnets_ids        = module.vpc.private_subnets
  security_group_ids = module.security_group.elasticache_security_groups_ids
}

module "bastion" {
  source = "../modules/bastion"

  subnet_ids                  = module.vpc.public_subnets
  instance_security_group_ids = module.security_group.bastion_security_groups_ids

  namespace     = local.namespace
  instance_type = var.bastion_instance_type

  min_instance_count     = var.bastion_min_instance_count
  max_instance_count     = var.bastion_max_instance_count
  instance_desired_count = var.bastion_instance_desired_count

  ami_id = var.bastion_ami_id
}
