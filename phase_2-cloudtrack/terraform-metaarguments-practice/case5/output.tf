output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = aws_subnet.main.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.app.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.app.name
}

output "ingress_rules_count" {
  description = "Number of ingress rules created"
  value       = length(var.ingress_rules)
}

output "ingress_rules_details" {
  description = "Details of all ingress rules"
  value = [
    for rule in var.ingress_rules :
    "Port ${rule.port}/${rule.protocol} - ${rule.description} from ${rule.cidr}"
  ]
}
