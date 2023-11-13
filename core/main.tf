module "vpc" {
  source = "../modules/vpc"

  namespace = local.namespace
}
