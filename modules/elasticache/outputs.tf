output "redis_primary_endpoint" {
  description = "Primary endpoint of the Redis cluster"
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}
