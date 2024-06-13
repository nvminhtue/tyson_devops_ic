locals {
  user_accounts = var.has_login ? aws_iam_user.user_account : {}

  path = "/"
}
