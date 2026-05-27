output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = {
    for k, v in aws_subnet.all :
    k => v.id
    if v.tags.Type == "public"
  }
}

output "app_subnets" {
  value = {
    for k, v in aws_subnet.all :
    k => v.id
    if v.tags.Type == "app"
  }
}

output "db_subnets" {
  value = {
    for k, v in aws_subnet.all :
    k => v.id
    if v.tags.Type == "db"
  }
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.main[*].id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "app_sg_id" {
  value = aws_security_group.app.id
}