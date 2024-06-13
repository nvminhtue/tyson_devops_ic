module "vpc" {
  source = "../modules/vpc"

  namespace = local.namespace
}

module "ssm" {
  source = "../modules/ssm"

  env_namespace = local.namespace
  secrets = {
    secret_key_base = var.secret_key_base
  }
}
