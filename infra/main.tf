module "resource_group" {
  source = "./modules/resource_group"
}

module "service_plan" {
  source                  = "./modules/service_plan"
  project_name            = var.project_name
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
}

module "redis_cache" {
  source                  = "./modules/redis_cache"
  project_name            = var.project_name
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
}

module "linux_web_app" {
  source                            = "./modules/linux_web_app"
  project_name                      = var.project_name
  resource_group_name               = module.resource_group.resource_group_name
  resource_group_location           = module.resource_group.resource_group_location
  service_plan_id                   = module.service_plan.id
  container_registry_admin_username = module.container_registry.admin_username
  container_registry_admin_password = module.container_registry.admin_password
  redis_host                        = module.redis_cache.hostname
  redis_port                        = module.redis_cache.port
  redis_password                    = module.redis_cache.primary_access_key
  NEXTAUTH_SECRET                   = var.NEXTAUTH_SECRET
  NEXTAUTH_URL                      = var.NEXTAUTH_URL
  AUTH_GITHUB_ID                    = var.AUTH_GITHUB_ID
  AUTH_GITHUB_SECRET                = var.AUTH_GITHUB_SECRET
  OPENAI_API_KEY                    = var.OPENAI_API_KEY
}

module "container_registry" {
  source                  = "./modules/container_registry"
  project_name            = var.project_name
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
}

