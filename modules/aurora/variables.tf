variable "aurora_cluster_identifier" {
  description = "The identifier for the Aurora cluster"
  type        = string
}

variable "aurora_engine_version" {
  description = "The version of the Aurora engine"
  type        = string
}

variable "aurora_master_username" {
  description = "The master username for the database"
  type        = string
}

variable "aurora_master_password" {
  description = "The master password for the database"
  type        = string
}

variable "aurora_database_name" {
  description = "The name of the database"
  type        = string
}

variable "aurora_backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
}

variable "aurora_preferred_backup_window" {
  description = "The daily time range during which backups are created"
  type        = string
}

variable "aurora_db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "aurora_subnet_ids" {
  description = "The list of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "aurora_instance_count" {
  description = "The number of instances in the Aurora cluster"
  type        = number
}

variable "aurora_instance_class" {
  description = "The instance class for the Aurora instances"
  type        = string
}

variable "aurora_vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "aurora_ingress_port" {
  description = "The ingress port for the security group"
  type        = number
}

variable "aurora_ingress_cidr_blocks" {
  description = "The list of ingress CIDR blocks"
  type        = list(string)
}

variable "aurora_egress_rules" {
  description = "The egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
