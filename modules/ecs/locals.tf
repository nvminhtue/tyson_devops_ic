locals {
  ecs_task_execution_ssm_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameters"
        ],
        Resource = var.secrets_arns
      }
    ]
  })

  ecs_task_execution_service_scaling_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "application-autoscaling:*",
          "ecs:DescribeServices",
          "ecs:UpdateService",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:DisableAlarmActions",
          "cloudwatch:EnableAlarmActions",
          "iam:CreateServiceLinkedRole",
        ],
        Resource = "*"
      }
    ]
  })


  ecs_task_execution_role_assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  container_vars = {
    namespace                          = var.namespace
    region                             = var.region
    app_host                           = var.app_host
    app_port                           = var.app_port
    cpu                                = var.cpu
    memory                             = var.memory
    deployment_maximum_percent         = var.deployment_maximum_percent
    deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
    ecr_repo_name                      = var.ecr_repo_name
    ecr_tag                            = var.ecr_tag
    aws_cloudwatch_log_group_name      = var.aws_cloudwatch_log_group_name
    container_envs                     = var.container_envs
    secrets_variables                  = var.secrets_variables
  }

  container_name = "${var.namespace}-${var.ecr_repo_name}-${var.ecr_tag}"
  service_name   = "${local.container_name}-service"

  scale_in_cooldown_period  = 300
  scale_out_cooldown_period = 300
}
