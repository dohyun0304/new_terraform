variable "instances" {
  description = "Map of public instances"
  type = map(object({
    ami_id        = string
    instance_type = string
    name          = string
    environment   = string
    eip           = bool
    subnet_id     = string
  }))
}

variable "instance_sg_rule" {
  description = "Security group rules for public instances"
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

variable "eip_allocation_ids" {
  description = "Map of EIP allocation IDs"
  type        = map(string)
}
