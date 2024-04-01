# Bypass the MEDIUM severity for VPC Flow Logs
# trivy:ignore:AVD-AWS-0178
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = local.vpc_name
  cidr = var.cidr
}
