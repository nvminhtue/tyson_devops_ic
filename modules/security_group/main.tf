resource "aws_security_group" "rds" {
  name        = "${var.namespace}-rds"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.namespace}-rds-sg"
  }
}
