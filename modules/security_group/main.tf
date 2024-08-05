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

resource "aws_security_group" "bastion" {
  name        = "${var.namespace}-bastion-sg"
  description = "Bastion Host security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.namespace}-bastion-sg"
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
  protocol    = "-1"
  from_port   = 0
  to_port     = 65535
  cidr_blocks = var.private_subnets_cidr_blocks
  description = "From private subnets to ECS Fargate"
}

resource "aws_security_group_rule" "ecs_fargate_egress_anywhere" {
  type              = "egress"
  security_group_id = aws_security_group.ecs_fargate.id
  protocol          = "-1"
  // No specific ports
  from_port   = 0
  to_port     = 0
  cidr_blocks = ["0.0.0.0/0"]
  description = "From ECS Fargate to anywhere"
}

resource "aws_security_group" "elasticache" {
  name        = "${var.namespace}-elasticache-sg"
  description = "Elasticache security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.namespace}-elasticache-sg"
  }
}

resource "aws_security_group_rule" "elasticache_ingress_fargate" {
  description              = "From ECS Fargate to Elasticache"
  type                     = "ingress"
  security_group_id        = aws_security_group.elasticache.id
  protocol                 = "tcp"
  from_port                = 6379
  to_port                  = 6379
  source_security_group_id = aws_security_group.ecs_fargate.id
}

resource "aws_security_group_rule" "rds_ingress_app_fargate" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_fargate.id
  description              = "From app to DB"
}

resource "aws_security_group_rule" "bastion_ingress_ssh" {
  description       = "SSH to bastion from anywhere"
  type              = "ingress"
  security_group_id = aws_security_group.bastion.id
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_egress_rds" {
  description              = "Outgoing from bastion to RDS"
  type                     = "egress"
  security_group_id        = aws_security_group.bastion.id
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  source_security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_ingress_bastion" {
  description              = "Incoming from bastion to RDS"
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
}
