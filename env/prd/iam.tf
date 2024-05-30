module "iam" {
  source = "../../modules/iam"

  admin_group_name = var.admin_group_name
  admin_policy_arn = var.admin_policy_arn
  user_names       = var.user_names
}
