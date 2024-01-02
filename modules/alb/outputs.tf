output "alb_name" {
  description = "ALB name"
  value       = aws_lb.this.name
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "ALB zone ID"
  value       = aws_lb.this.zone_id
}

output "alb_target_group_arn" {
  description = "ALB target group ARN"
  value       = aws_lb_target_group.this.arn
}
