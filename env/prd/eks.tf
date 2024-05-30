module "eks" {
  source                = "../../modules/eks"
  cluster_name          = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id                = module.vpc.vpc_id
  node_subnet_ids       = module.vpc.node_subnet_ids
  node_instance_types   = var.node_instance_types
  desired_capacity      = var.desired_capacity
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  cluster_sg_rules_cidr = var.cluster_sg_rules_cidr
  cluster_sg_rules_sg   = var.cluster_sg_rules_sg
  node_sg_rules_cidr    = var.node_sg_rules_cidr
  node_sg_rules_sg      = var.node_sg_rules_sg
  aws_auth_roles        = var.aws_auth_roles
  aws_auth_users        = var.aws_auth_users
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
}

module "alb_controller_role" {
  source = "../../modules/eks/alb_controller"
  cluster_name            = var.cluster_name
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
}
