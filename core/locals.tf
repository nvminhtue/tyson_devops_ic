locals {
  app_name  = "devops-ic"
  region    = "ap-southeast-1"
  namespace = "${local.app_name}-${var.environment}"

  app_port          = 4000
  health_check_path = "/"

  ecs_config = {
    staging = jsondecode(file("assets/ecs_config/staging.json"))
    prod    = jsondecode(file("assets/ecs_config/prod.json"))
  }
  current_ecs_config = local.ecs_config[var.environment]
  container_variables = {
    staging = [for k, v in jsondecode(file("assets/container_variables/staging.json")) : { name = k, value = v }]
    prod    = [for k, v in jsondecode(file("assets/container_variables/prod.json")) : { name = k, value = v }]
  }
  ecs_container_variables = local.container_variables[var.environment]
}
