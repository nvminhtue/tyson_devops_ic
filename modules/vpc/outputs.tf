output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets_cidr_blocks" {
  description = "Private subnets CIDR blocks"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "database_subnets" {
  description = "Database subnets"
  value       = data.aws_subnets.private_subnets.ids
}
