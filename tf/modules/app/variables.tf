variable "app_name" {
    type = string
}

variable "app_subnets" {
    type = list(string)
}

variable "app_vpc_id" {
    type = string
}

variable "additional_tags" {
    type = map(string)
    default = {}
}

variable "public_key" {
    type = string
}

variable "instance_type" {
    type = string
    default = "t3.small"
}

variable "target_group" {
    type = string
}

variable "app_cidr_access" {
    default  = ["0.0.0.0/0"]
}

variable "app_cidr_management" {
    type = list(string)
    default  = []
}
