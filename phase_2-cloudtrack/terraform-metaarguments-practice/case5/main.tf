resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "${var.project_name}-vpc"
        Project = var.project_name
    }
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id 
    cidr_block = var.subnet_cidr
    availability_zone = "${var.aws_region}a"

    tags = {
    Name    = "${var.project_name}-subnet"
    Project = var.project_name
  }
}

resource "aws_security_group" "app" {
    vpc_id = aws_vpc.main.id 
    name        = "${var.project_name}-sg"
    description = "Security group for ${var.project_name} with dynamic ingress rules"

    dynamic "ingress" {
        for_each = var.ingress_rules

        content {
            from_port = ingress.value.port
            to_port = ingress.value.port
            protocol = ingress.value.protocol
            cidr_blocks = [ingress.value.cidr]
            description = ingress.value.description
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name    = "${var.project_name}-sg"
        Project = var.project_name
  }
}