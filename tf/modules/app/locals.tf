locals {
    tags = merge({Name=var.app_name}, var.additional_tags)
}
