output "rds_security_groups_ids" {
  description = "List of RDS security group IDs"
  value       = [aws_security_group.rds.id]
}
