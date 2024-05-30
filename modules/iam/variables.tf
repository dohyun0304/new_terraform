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
