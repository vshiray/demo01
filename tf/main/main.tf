terraform {
    required_version = "~> 1.0"
}

module "vpc_demo" {
    source = "../modules/vpc"
    vpc_name = var.demo_name
    vpc_cidr = var.vpc_cidr
    subnet_zones = slice(data.aws_availability_zones.available.names, 0, 2)
    additional_tags = var.additional_tags
}

module "alb_demo" {
    source = "../modules/alb"
    alb_name = var.demo_name
    alb_subnets = tolist([module.vpc_demo.first_subnet_id, module.vpc_demo.second_subnet_id])
    alb_vpc_id = module.vpc_demo.vpc_id
    additional_tags = var.additional_tags
    zone_id = data.aws_route53_zone.main.zone_id
}

module "app_demo" {
    source = "../modules/app"
    app_name = var.demo_name
    app_subnets = tolist([module.vpc_demo.first_subnet_id, module.vpc_demo.second_subnet_id])
    app_vpc_id = module.vpc_demo.vpc_id
    app_cidr_access = [var.vpc_cidr]
    app_cidr_management = var.management_cidr_blocks
    additional_tags = var.additional_tags
    public_key = var.public_key
    target_group = module.alb_demo.target_group
}
