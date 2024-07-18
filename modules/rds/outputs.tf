output "cluster_endpoint" {
  value = module.rds.cluster_endpoint
}

output "cluster_id" {
  value = module.db.cluster_id
}
