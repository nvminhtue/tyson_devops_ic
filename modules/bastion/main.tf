resource "aws_launch_template" "bastion_instance" {
  name_prefix = "${var.namespace}-bastion-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = "${var.namespace}-bastion"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "terminate"

  ebs_optimized = true

  # instance_requirements {
  #   vcpu_count {
  #     min = 1
  #     max = 1
  #   }
  #   memory_mib {
  #     min = 512
  #     max = 1024
  #   }
  # }

  # iam_instance_profile {
  #   name = aws_iam_instance_profile.bastion.name
  # }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.instance_security_group_ids
  }

  metadata_options {
    http_tokens = "required"
  }
}

resource "aws_autoscaling_group" "bastion_instance" {
  name                = "${var.namespace}-bastion"
  min_size            = var.min_instance_count
  max_size            = var.max_instance_count
  desired_capacity    = var.instance_desired_count
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.bastion_instance.id
    version = aws_launch_template.bastion_instance.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.namespace}-bastion"
    propagate_at_launch = true
  }
}
