resource "aws_iam_group" "admin_group" {
  name = var.admin_group_name
}

resource "aws_iam_group_policy_attachment" "admin_group_policy" {
  group      = aws_iam_group.admin_group.name
  policy_arn = var.admin_policy_arn
}

resource "aws_iam_user" "admin_users" {
  for_each = toset(var.user_names)
  name     = each.key
}

resource "aws_iam_group_membership" "admin_group_membership" {
  name  = "admin-group-membership"
  group = aws_iam_group.admin_group.name
  users = [for user in aws_iam_user.admin_users : user.name]
}
