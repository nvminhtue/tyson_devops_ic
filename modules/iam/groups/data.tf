data "aws_iam_policy" "admin" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy" "power_user" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
