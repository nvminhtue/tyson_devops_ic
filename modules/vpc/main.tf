# trivy:ignore:AVD-AWS-0017 trivy:ignore:AVD-AWS-0102 trivy:ignore:AVD-AWS-0105 trivy:ignore:AVD-AWS-0178 trivy:ignore:AVD-AWS-0101 trivy:ignore:AVD-AWS-0105
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name                   = local.vpc_name
  cidr                   = var.cidr
  azs                    = local.azs
  private_subnets        = local.private_subnets
  public_subnets         = local.public_subnets
  enable_nat_gateway     = local.enable_nat_gateway
  single_nat_gateway     = local.single_nat_gateway
  one_nat_gateway_per_az = local.one_nat_gateway_per_az
  enable_dns_hostnames   = local.enable_dns_hostnames
}
