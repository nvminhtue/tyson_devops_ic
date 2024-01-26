terraform {
  cloud {
    organization = "nvminhtue"

    workspaces {
      tags = ["aws-infrastructure"]
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
  region     = local.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
    }
  }
}
