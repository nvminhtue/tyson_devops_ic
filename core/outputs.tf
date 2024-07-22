output "cluster_endpoint" {
  value = module.rds.cluster_endpoint
}

output "cluster_id" {
  value = module.rds.cluster_id
}

output "secrets_variables" {
  value = module.ssm.secrets_variables
}
