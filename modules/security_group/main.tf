resource "aws_security_group" "rds" {
  name        = "${var.namespace}-rds"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.namespace}-rds-sg"
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.namespace}-alb-sg"
  description = "ALB security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.namespace}-alb-sg"
  }
}

resource "aws_security_group_rule" "alb_ingress_http" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "From HTTP to ALB"
}
