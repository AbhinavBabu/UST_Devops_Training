output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "subnet_id" {
  value = aws_subnet.main.id
}

output "subnet_cidr" {
  value = aws_subnet.main.cidr_block
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "security_group_id" {
  value = aws_security_group.main.id
}

output "security_group_name" {
  value = aws_security_group.main.name
}
