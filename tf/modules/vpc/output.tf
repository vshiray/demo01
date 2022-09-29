output "first_subnet_id" {
  value = aws_subnet.first.id
}

output "second_subnet_id" {
  value = aws_subnet.second.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
