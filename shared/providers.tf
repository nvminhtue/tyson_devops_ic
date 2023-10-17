provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
    }
  }
}
