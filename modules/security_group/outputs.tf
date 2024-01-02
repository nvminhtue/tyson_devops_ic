output "rds_security_groups_ids" {
  description = "List of RDS security group IDs"
  value       = [aws_security_group.rds.id]
}

output "alb_security_groups_ids" {
  description = "List of ALB security group IDs"
  value       = [aws_security_group.alb.id]
}
