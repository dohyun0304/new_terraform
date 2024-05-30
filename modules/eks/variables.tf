variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed."
  type        = string
}

variable "node_subnet_ids" {
  description = "A list of subnet IDs for the EKS nodes."
  type        = list(string)
}

variable "node_instance_types" {
  description = "The instance type to use for the EKS nodes."
  type        = list(string)
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

variable "aws_auth_roles" {
  description = "List of IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_users" {
  description = "List of IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDRs allowed access to the EKS cluster public endpoint."
  type        = list(string)
}

variable "cluster_sg_rules_cidr" {
  type = map(object({
    type      = string
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = string
  }))
}

variable "cluster_sg_rules_sg" {
  type = map(object({
    type      = string
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "node_sg_rules_cidr" {
  type = map(object({
    type      = string
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = string
  }))
}

variable "node_sg_rules_sg" {
  type = map(object({
    type      = string
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

