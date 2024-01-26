terraform {
  cloud {
    organization = "nvminhtue"

    workspaces {
      name = "devops-ic-shared"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = "1.6.1"
}

provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
    }
  }
}
