data "aws_availability_zone" "first" {
  name = var.subnet_zones[0]
}

data "aws_availability_zone" "second" {
  name = var.subnet_zones[1]
}
