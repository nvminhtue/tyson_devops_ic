module "ecr" {
  source = "../modules/ecr"

  namespace   = local.app_name
  image_limit = var.image_limit
}
