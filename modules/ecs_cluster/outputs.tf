output "aws_ecs_cluster_attributes" {
  description = "ECS cluster attributes"

  value = {
    id   = aws_ecs_cluster.this.id
    name = aws_ecs_cluster.this.name
  }
}
