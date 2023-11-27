resource "aws_iam_group_membership" "iam_group" {
  name = var.name

  group = var.group
  users = var.users
}
