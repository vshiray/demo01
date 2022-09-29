locals {
    tags = merge({Name=var.alb_name}, var.additional_tags)
}
