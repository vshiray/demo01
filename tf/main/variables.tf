variable "aws_profile" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "additional_tags" {
    type = map(string)
    default = {}
}

variable "public_key" {
    type = string
}

variable "dns_zone" {
    type = string
}

variable "vpc_cidr" {
    type = string
    default = "10.2.0.0/16"
}

variable "demo_name" {
    type = string
    default = "vladimir-demo"
}

variable "management_cidr_blocks" {
    type = list(string)
    default = []
}
