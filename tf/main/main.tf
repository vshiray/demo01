terraform {
    required_version = "~> 1.0"
}

module "vpc_demo" {
    source = "../modules/vpc"
    vpc_name = "vladimir-demo"
    vpc_cidr = "10.2.0.0/16"
    subnet_zones = slice(data.aws_availability_zones.available.names, 0, 2)
    additional_tags = var.additional_tags
}

module "alb_demo" {
    source = "../modules/alb"
    alb_name = "vladimir-demo"
    alb_subnets = tolist([module.vpc_demo.first_subnet_id, module.vpc_demo.second_subnet_id])
    alb_vpc_id = module.vpc_demo.vpc_id
    additional_tags = var.additional_tags
    zone_id = data.aws_route53_zone.main.zone_id
}

module "app_demo" {
    source = "../modules/app"
    app_name = "vladimir-demo"
    app_subnets = tolist([module.vpc_demo.first_subnet_id, module.vpc_demo.second_subnet_id])
    app_vpc_id = module.vpc_demo.vpc_id
    additional_tags = var.additional_tags
    public_key = var.public_key
    target_group = module.alb_demo.target_group
}
