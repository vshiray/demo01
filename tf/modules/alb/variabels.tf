variable "alb_vpc_id" {
    type = string
}

variable "alb_name" {
    type = string
}

variable "alb_subnets" {
    type = list(string)
}

variable "additional_tags" {
    type = map(string)
    default = {}
}

variable "zone_id" {
    type = string
}

variable "dns_name" {
    type = string
    default = "demo01"
}
