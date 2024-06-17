module "public_ec2_instances" {
  source           = "../../modules/ec2/public_ec2"
  instances        = { for k, v in var.public_instances : k => merge(v, { subnet_id = element(module.vpc.public_subnet_ids, index(keys(var.public_instances), k)) }) }
  instance_sg_rule = var.public_instance_sg_rule
  vpc_id           = module.vpc.vpc_id
  eip_allocation_ids = { for k, v in var.public_instances : k => element(module.vpc.public_instance_eip_ids, index(keys(var.public_instances), k)) }
}

module "private_ec2_instances" {
  source           = "../../modules/ec2/private_ec2"
  instances        = { for k, v in var.private_instances : k => merge(v, { subnet_id = element(module.vpc.private_subnet_ids, index(keys(var.private_instances), k)) }) }
  instance_sg_rule = var.private_instance_sg_rule
  vpc_id           = module.vpc.vpc_id
}
