locals {
    tags = merge({Name=var.vpc_name}, var.additional_tags)
}
