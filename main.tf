module "nginx" {
  source      = "./modules/nginx"
  environment = var.environment
}

module "webpage" {
  source      = "./modules/webpage"
  environment = var.environment
}

# module "postgres" {
#   source      = "./modules/postgres"
#   environment = var.environment
# }