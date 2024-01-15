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

resource "aws_security_group" "ecs_fargate" {
  name        = "${var.namespace}-ecs-fargate-sg"
  description = "ECS Fargate security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.namespace}-ecs-fargate-sg"
  }
}

resource "aws_security_group_rule" "ecs_fargate_ingress_alb" {
  type = "ingress"

  security_group_id        = aws_security_group.ecs_fargate.id
  protocol                 = "tcp"
  from_port                = var.app_port
  to_port                  = var.app_port
  source_security_group_id = aws_security_group.alb.id
  description              = "From ALB to ECS Fargate"
}

resource "aws_security_group_rule" "ecs_fargate_ingress_private" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs_fargate.id
  // All protocols, ports are allowed to ECS Fargate
  protocol          = "-1"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = var.private_subnets_cidr_blocks
  description       = "From private subnets to ECS Fargate"
}

resource "aws_security_group_rule" "ecs_fargate_egress_anywhere" {
  type              = "egress"
  security_group_id = aws_security_group.ecs_fargate.id
  protocol          = "-1"
  // No specific ports
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "From ECS Fargate to anywhere"
}
