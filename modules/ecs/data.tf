data "aws_ecs_task_definition" "task" {
  task_definition = aws_ecs_task_definition.this.family
}
