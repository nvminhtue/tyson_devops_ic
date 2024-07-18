resource "aws_lb" "this" {
  name               = "${var.namespace}-alb"
  subnets            = var.subnets_ids
  load_balancer_type = "application"
  security_groups    = var.security_group_ids

  enable_deletion_protection = true
  drop_invalid_header_fields = true


  access_logs {
    bucket  = "${var.namespace}-bucket"
    enabled = true
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.namespace}-alb-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    interval            = 5
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = 3
    path                = var.health_check_path
    port                = var.app_port
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "app_http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

// TODO: Add HTTPS listener if still have time
