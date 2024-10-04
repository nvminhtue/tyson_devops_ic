# Bypass the LOW severity check: Repository is not encrypted using KMS
# trivy:ignore:AVD-AWS-0033
resource "aws_ecr_repository" "main" {
  name = var.namespace

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = local.image_tag_mutability
}

resource "aws_ecr_lifecycle_policy" "main_policy" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = concat(local.primary_image_rules, local.secondary_image_rules, local.untagged_image_rules)
  })
}
