// Define groups
resource "aws_iam_group" "admin" {
  name = "Admin-group"
}

resource "aws_iam_group" "bot" {
  name = "Bot-group"
}

resource "aws_iam_group" "developer" {
  name = "Developer-group"
}

// Define policies
data "aws_iam_group_policy" "developer_allow_manage_own_credentials" {
  group  = aws_iam_group.developer.name
  policy = local.allow_manage_own_credentials
}

data "aws_iam_group_policy" "bot_full_iam_access" {
  group  = aws_iam_group.bot.name
  policy = local.full_iam_access_policy
}

// Define policy attachments
resource "aws_iam_group_policy_attachment" "admin_access" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin_policy.arn
}

resource "aws_iam_group_policy_attachment" "developer_power_user_access" {
  group      = aws_iam_group.developer.name
  policy_arn = data.aws_iam_policy.power_user_policy.arn
}

resource "aws_iam_group_policy_attachment" "bot_power_user_access" {
  group      = aws_iam_group.bot.name
  policy_arn = data.aws_iam_policy.power_user_policy.arn
}
