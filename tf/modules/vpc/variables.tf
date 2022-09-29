variable "vpc_cidr" {}

variable "vpc_name" {}

variable "subnet_zones" {
    type = list(string)
}

variable "additional_tags" {
    type = map(string)
    default = {}
}
