output "rds_security_groups_ids" {
  description = "List of RDS security group IDs"
  value       = [aws_security_group.rds.id]
}

output "alb_security_groups_ids" {
  description = "List of ALB security group IDs"
  value       = [aws_security_group.alb.id]
}

output "elasticache_security_groups_ids" {
  description = "List of Elasticache security group IDs"
  value       = [aws_security_group.elasticache.id]
}
