locals {
  ecs_container_definitions_content = file("${path.module}/../../modules/ecs/ecs_container_definitions.json")
  ecs_selected_subnets = [module.vpc.private_subnet_ids[1]]
}

module "ecs" {
  source                   = "../../modules/ecs"
  ecs_cluster_name         = var.ecs_cluster_name
  vpc_id                   = module.vpc.vpc_id
  ecs_subnet_ids           = local.ecs_selected_subnets
  ecs_container_definitions = local.ecs_container_definitions_content
  ecs_task_cpu             = var.ecs_task_cpu
  ecs_task_memory          = var.ecs_task_memory
  ecs_desired_count        = var.ecs_desired_count
  ecs_ingress_ports        = var.ecs_ingress_ports
  ecs_egress_ports         = var.ecs_egress_ports
}
