output "private_subnets" {
  value = module.vpc.private_subnets
}

output "elasticache_redis_primary_endpoint" {
  value = module.elasticache.redis_primary_endpoint
}
