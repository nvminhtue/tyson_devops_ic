data "aws_subnets" "private_subnets" {
  tags = {
    Tier = "Private"
  }
}
