module "aurora" {
  source = "../../modules/aurora"

  aurora_cluster_identifier       = var.aurora_cluster_identifier
  aurora_engine_version           = var.aurora_engine_version
  aurora_master_username          = var.aurora_master_username
  aurora_master_password          = var.aurora_master_password
  aurora_database_name            = var.aurora_database_name
  aurora_backup_retention_period  = var.aurora_backup_retention_period
  aurora_preferred_backup_window  = var.aurora_preferred_backup_window
  aurora_db_subnet_group_name     = var.aurora_db_subnet_group_name
  aurora_subnet_ids               = module.vpc.private_subnet_ids
  aurora_instance_count           = var.aurora_instance_count
  aurora_instance_class           = var.aurora_instance_class
  aurora_vpc_id                   = module.vpc.vpc_id
  aurora_ingress_port             = var.aurora_ingress_port
  aurora_ingress_cidr_blocks      = var.aurora_ingress_cidr_blocks
  aurora_egress_rules             = var.aurora_egress_rules
}
