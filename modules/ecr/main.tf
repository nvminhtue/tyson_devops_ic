resource "aws_ecr_repository" "main" {
  name = var.namespace

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "main_policy" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = concat([local.primary_image_rules, local.secondary_image_rules, local.untagged_image_rules])
  })
}
