variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

variable "ecs_subnet_ids" {
  description = "List of private subnet IDs for the ECS service"
  type        = list(string)
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_container_definitions" {
  description = "Container definitions for the ECS task"
  type        = string
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
