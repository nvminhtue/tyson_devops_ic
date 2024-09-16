output "cluster_database_name" {
  value = module.rds.db_subnet_group_name
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
