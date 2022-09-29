resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = local.tags
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = local.tags
}

resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
    tags = local.tags
}

resource "aws_route" "public" {
    route_table_id = aws_route_table.main.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
}

resource "aws_main_route_table_association" "main" {
    vpc_id = aws_vpc.main.id
    route_table_id = aws_route_table.main.id
}

resource "aws_subnet" "first" {
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr, 4, 0)
    availability_zone = data.aws_availability_zone.first.name
    tags = local.tags
}

resource "aws_subnet" "second" {
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr, 4, 1)
    availability_zone = data.aws_availability_zone.second.name
    tags = local.tags
}
