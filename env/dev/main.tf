module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  vpc_name       = var.vpc_name
  environment    = var.environment
}

module "subnets" {
  source = "../../modules/subnets"

  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  az_count       = var.az_count
  environment    = var.environment
  domain         = var.domain
  depends_on     = [module.vpc]
}

module "security_groups" {
  source = "../../modules/security_groups"

  vpc_id            = module.vpc.vpc_id
  alb_listener_port = var.alb_listener_port
  container_port    = var.container_port
  environment       = var.environment
  domain            = var.domain
  depends_on        = [module.vpc]
}

module "gateway" {
  source = "../../modules/gateway"

  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_id
  environment      = var.environment
  domain           = var.domain
  depends_on       = [module.vpc]
}

module "route_tables" {
  source = "../../modules/route_tables"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  internet_gateway_id = module.gateway.internet_gateway_id
  nat_gateway_id      = module.gateway.nat_gateway_id
  environment         = var.environment
  domain              = var.domain
  depends_on          = [module.vpc]
}

module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
  alb_listener_port = var.alb_listener_port
  container_port    = var.container_port
  environment       = var.environment
  domain            = var.domain
  depends_on        = [module.vpc]
}

module "ecs" {
  source = "../../modules/ecs"

  ecs_fargate_task_total_mem = var.ecs_fargate_task_total_mem
  ecs_fargate_task_total_cpu = var.ecs_fargate_task_total_cpu
  ecs_task_desired_count     = var.ecs_task_desired_count
  private_subnet_ids         = module.subnets.private_subnet_ids
  ecs_task_sg_id             = module.security_groups.ecs_task_sg_id
  alb_target_group_arn       = module.alb.alb_target_group_arn
  alb_listener_arn           = module.alb.alb_listener_arn

  environment     = var.environment
  container_image = var.container_image
  container_port  = var.container_port
  domain          = var.domain
  depends_on = [
    module.vpc,
    module.subnets,
    module.security_groups,
    module.gateway,
    module.route_tables,
    module.alb
  ]
}

# module "s3" {
#   source = "../../modules/s3"

#   environment = var.environment
#   domain      = var.domain
# }