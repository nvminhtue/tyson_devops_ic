output "redis_primary_endpoint" {
  description = "Primary endpoint of the Redis cluster address"
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}
