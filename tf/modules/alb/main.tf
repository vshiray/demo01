resource "aws_security_group" "main" {
    name = "${var.alb_name}-alb"
    description = "Application Load Balancer"
    vpc_id = var.alb_vpc_id
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags = local.tags
}

resource "aws_lb" "main" {
    name = var.alb_name
    internal = false
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    subnets = var.alb_subnets
    security_groups = [aws_security_group.main.id]
    enable_cross_zone_load_balancing = true
    enable_http2 = true
    tags = local.tags
}

resource "aws_lb_target_group" "main" {
    name = var.alb_name
    port = 8000
    protocol = "HTTP"
    vpc_id = var.alb_vpc_id
    tags = local.tags
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.main.arn
    port = 80
    protocol = "HTTP"
    
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }
}

resource "aws_route53_record" "region" {
    zone_id = var.zone_id
    name = var.dns_name
    type = "A"
    
    alias {
        name = aws_lb.main.dns_name
        zone_id = aws_lb.main.zone_id
        evaluate_target_health = false
    }
}
