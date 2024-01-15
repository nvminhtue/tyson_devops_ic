# AWS IAM POLICIES
resource "aws_iam_policy" "ecs_task_execution_ssm" {
  name   = "${var.namespace}-ecs-task-execution-ssm-policy"
  policy = local.ecs_task_execution_ssm_policy
}

resource "aws_iam_policy" "ecs_task_execution_service_scaling" {
  name   = "${var.namespace}-ecs-task-execution-service-scaling-policy"
  policy = local.ecs_task_execution_service_scaling_policy
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.namespace}-ecs-task-execution-role"
  assume_role_policy = local.ecs_task_execution_role_assume_role_policy
}

# AWS IAM POLICY ATTACHMENTS
resource "aws_iam_role_policy_attachment" "ecs_task_execution_ssm_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_ssm.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_excution_service_scaling_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_service_scaling.arn
}

# AWS ECS TASK DEFINITION
resource "aws_ecs_task_definition" "this" {
  container_definitions    = templatefile("${path.module}/service.json.tftpl", local.container_vars)
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  family                   = local.service_name
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "this" {
  name                               = "${local.container_name}-ecs-service"
  cluster                            = var.ecs_cluster_id
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  launch_type                        = "FARGATE"
  task_definition                    = "${aws_ecs_task_definition.this.family}:${max("${aws_ecs_task_definition.this.revision}", "${data.aws_ecs_task_definition.task.revision}")}"


  # Rollback to the last successful deployment
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # Specify subnets and security groups to use for tasks
  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  # Specify the load balancer to use for tasks
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = local.container_name
    container_port   = var.app_port
  }

  # Ignore changes in desired count when scaling, preventing Terraform from overwriting manual scaling actions taken outside of Terraform
  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_appautoscaling_target" "this" {
  max_capacity       = var.max_instance_count
  min_capacity       = var.min_instance_count
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# AWS APPAUTOSCALING POLICIES
# Automatically adjust the number of tasks based on memory usage
resource "aws_appautoscaling_policy" "memory_policy" {
  name               = "${var.namespace}-appautoscaling-memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      # scales the target based on the average memory utilization of the ECS service.
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    # Specifies the cooldown period after a scale-in/scale-out event (when the service scales down/up) before another scale-in/scale-out action can take place.
    scale_in_cooldown  = local.scale_in_cooldown_period
    scale_out_cooldown = local.scale_out_cooldown_period

    # Indicates the target value for the average memory utilization percentage that the auto scaling policy aims to maintain
    target_value = var.autoscaling_target_memory_percentage
  }
}

# Automatically adjust the number of tasks based on CPU usage
resource "aws_appautoscaling_policy" "cpu_policy" {
  name               = "${var.namespace}-appautoscaling-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      # scales the target based on the average CPU utilization of the ECS service.
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    # Specifies the cooldown period after a scale-in/scale-out event (when the service scales down/up) before another scale-in/scale-out action can take place.
    scale_in_cooldown  = local.scale_in_cooldown_period
    scale_out_cooldown = local.scale_out_cooldown_period

    # Indicates the target value for the average CPU utilization percentage that the auto scaling policy aims to maintain
    target_value = var.autoscaling_target_cpu_percentage
  }
}
