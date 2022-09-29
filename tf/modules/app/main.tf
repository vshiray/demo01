resource "aws_key_pair" "main" {
    key_name = var.app_name
    public_key = var.public_key
}

resource "aws_security_group" "main" {
    name = var.app_name
    description = "Demo instance"
    vpc_id = var.app_vpc_id
    # management access
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # application port
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = local.tags
}

resource "aws_launch_configuration" "main" {
    name_prefix = "${var.app_name}-"
    image_id = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.main.key_name
    security_groups = [aws_security_group.main.id]
    user_data = data.template_file.main.rendered
    associate_public_ip_address = true
    root_block_device {
        volume_type = "gp3"
        volume_size = "10"
    }
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "main" {
    name = var.app_name
    max_size = 2
    min_size = 1
    launch_configuration = aws_launch_configuration.main.name
    health_check_grace_period = 300
    health_check_type = "EC2"
    target_group_arns = [var.target_group]
    vpc_zone_identifier = var.app_subnets
    dynamic "tag" {
        for_each = local.tags
        content {
            key = tag.key
            value = tag.value
            propagate_at_launch = true
        }
    }
    lifecycle {
        create_before_destroy = true
    }
}
