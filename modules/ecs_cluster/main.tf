resource "aws_ecs_cluster" "this" {
  name = "${var.namespace}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
