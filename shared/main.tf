module "ecr" {
  source = "../modules/ecr"

  namespace = local.app_name
}
