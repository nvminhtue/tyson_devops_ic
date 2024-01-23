variable "namespace" {
  description = "The namespace of the environment, e.g. `acme-web-staging`"
  type        = string
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "secrets_arns" {
  description = "List of SSM parameter store arns for secrets"
  type        = list(string)
}

variable "cpu" {
  description = "ECS task definition CPU units, e.g. 512"
  type        = number
}

variable "memory" {
  description = "ECS task definition memory, e.g. 1024"
  type        = number
}

variable "deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment, e.g. 200"
  type        = number
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment, e.g. 100"
  type        = number
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "security_groups" {
  description = "List of VPC security groups to associate"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "app_host" {
  description = "Application hostname"
  type        = string
}

variable "app_port" {
  description = "Application running port"
  type        = number
}

variable "max_instance_count" {
  description = "Maximum number of autoscaling instances"
  type        = number
}

variable "min_instance_count" {
  description = "Minimum number of autoscaling instances"
  type        = number
}

variable "autoscaling_target_memory_percentage" {
  description = "Autoscaling target memory percentage"
  type        = number
}

variable "autoscaling_target_cpu_percentage" {
  description = "Autoscaling target cpu percentage"
  type        = number
}

variable "ecr_repo_name" {
  description = "AWS ECR repository"
  type        = string
}

variable "ecr_tag" {
  description = "AWS ECR image deployment tag"
  type        = string
}

variable "aws_cloudwatch_log_group_name" {
  description = "AWS Cloudwatch log group name"
  type        = string
}

variable "environment_variables" {
  description = "Container environment variables"
  type = set(object({
    name  = string
    value = string
  }))
}

variable "secrets_variables" {
  description = "Container secrets environment variables"
  type = set(object({
    name      = string
    valueFrom = string
  }))
}
