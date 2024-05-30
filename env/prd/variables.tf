#####################common#####################
variable "aws_access_key" { #git action에서는 생략
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" { #git action에서는 생략
  description = "AWS secret key"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "terraform" {
  description = "managed by terraform"
  type        = string
}

#####################VPC#####################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}


variable "private_subnets" {
  description = "Map of private subnets CIDR blocks for the VPC"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "public_subnets" {
  description = "Map of public subnets CIDR blocks for the VPC"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "node_subnets" {
  description = "Map of EKS Node subnets CIDR blocks for the VPC"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway in the VPC"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "Enable VPN gateway in the VPC"
  type        = bool
}

variable "public_route_cidrs" {
}

variable "node_route_cidrs" {
}

variable "public_instance_sg_rule" {
  description = "Security group rules"
  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })))
}

variable "private_instance_sg_rule" {
  description = "Security group rules"
  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })))
}



#####################EC2#####################
variable "public_instance_count" {
  description = "Number of public instances to create"
}

variable "private_instance_count" {
  description = "Number of private instances to create"
}

variable "public_ami_id" {
  description = "ID of the AMI to use for the public instance"
}

variable "private_ami_id" {
  description = "ID of the AMI to use for the private instance"
}

variable "public_instance_type" {
  description = "Type of public instance"
}

variable "private_instance_type" {
  description = "Type of private instance"
}

variable "public_name" {
  description = "Name tag for public resources"
}

variable "private_name" {
  description = "Name tag for private resources"
}
variable "environment" {
  description = "Environment tag for resources"
}


####################EKS
variable "cluster_name" {
  description = "Name tag for the EKS"
  type        = string
}
variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}
variable "node_instance_types" {
  type = list(string)
}

variable "cluster_sg_rules_cidr" {
  type = map(any)
}

variable "cluster_sg_rules_sg" {
  type = map(any)
}

variable "node_sg_rules_cidr" {
  type = map(any)
}

variable "node_sg_rules_sg" {
  type = map(any)
}

variable "aws_auth_roles" {
  description = "List of IAM roles to map to EKS RBAC"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_users" {
  description = "List of IAM users to map to EKS RBAC"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDRs allowed access to EKS cluster endpoint"
  type = list(string)
}

variable "desired_capacity" {
  description = "The desired capacity for the EKS node group."
  type        = number
}

variable "min_capacity" {
  description = "The minimum capacity for the EKS node group."
  type        = number
}

variable "max_capacity" {
  description = "The maximum capacity for the EKS node group."
  type        = number
}


/*
variable "node_sg_rule" {
  description = "node Security group rules"

  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = any
  })))
}


variable "cluster_sg_rule" {
  description = "cluster Security group rules"

  type = map(list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = any
  })))
}
*/

#####################RDS#####################

variable "rds_name" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type = string
}

variable "rds_engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_db_name" {
  type = string
}

variable "rds_subnet_a_cidr" {
  type = string
}

variable "rds_subnet_b_cidr" {
  type = string
}

variable "rds_az_a" {
  type = string
}

variable "rds_az_b" {
  type = string
}
variable "rds_sg_rules_cidr" {
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
}

#################ECS################
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_subnet_ids" {
  description = "List of private subnet IDs for the ECS service"
  type        = list(string)
  default     = []
}


variable "ecs_task_cpu" {
  description = "CPU units for the ECS task"
  type        = string
}

variable "ecs_task_memory" {
  description = "Memory (MB) for the ECS task"
  type        = string
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "ecs_ingress_ports" {
  description = "List of ingress ports for the ECS Security Group"
  type        = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = list(string)
  }))
}

variable "ecs_egress_ports" {
  description = "List of egress ports for the ECS Security Group"
  type        = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = list(string)
  }))
}


#################Aurora################
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

variable "aurora_instance_count" {
  description = "The number of instances in the Aurora cluster"
  type        = number
}

variable "aurora_instance_class" {
  description = "The instance class for the Aurora instances"
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


#################Iam################
variable "admin_group_name" {
  description = "Name of the admin group"
  type        = string
}

variable "admin_policy_arn" {
  description = "ARN of the policy to attach to the admin group"
  type        = string
}

variable "user_names" {
  description = "List of IAM user names to create and add to the admin group"
  type        = list(string)
}
