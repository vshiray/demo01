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
