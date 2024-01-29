locals {
  primary_prefixes   = ["develop", "main"]
  secondary_prefixes = ["bug", "chore", "feature"]

  all_prefixes = concat(local.primary_prefixes, local.secondary_prefixes)

  // Sets max amount of the latest images to be kept
  image_limit = 5

  primary_image_rules = [
    for branch_prefix in local.primary_prefixes :
    {
      rulePriority = index(local.all_prefixes, branch_prefix) + 1
      description  = "Keep only ${local.image_limit} latest ${branch_prefix} images"
      selection = {
        countType     = "imageCountMoreThan"
        countNumber   = local.image_limit
        tagStatus     = "tagged"
        tagPrefixList = ["${branch_prefix}-"]
      }
      action = {
        type = "expire"
      }
    }
  ]

  secondary_image_rules = [
    for branch_prefix in local.secondary_prefixes :
    {
      rulePriority = index(local.all_prefixes, branch_prefix) + 1
      description  = "Keep only 1 latest ${branch_prefix} image"
      selection = {
        countType     = "imageCountMoreThan"
        countNumber   = 1
        tagStatus     = "tagged"
        tagPrefixList = ["${branch_prefix}-"]
      }
      action = {
        type = "expire"
      }
    }
  ]

  untagged_image_rules = [
    {
      rulePriority = length(local.all_prefixes) + 1
      description  = "Delete untagged images after 1 day"
      selection = {
        countType   = "sinceImagePushed"
        countNumber = 1
        countUnit   = "days"
        tagStatus   = "untagged"
      }
      action = {
        type = "expire"
      }
    }
  ]

  image_tag_mutability = "IMMUTABLE"
}
