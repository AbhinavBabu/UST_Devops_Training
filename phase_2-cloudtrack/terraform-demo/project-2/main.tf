terraform {
  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      version = "6.44.0"
    }
  }
}

provider "aws" {
    region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.aws_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.aws_vpc_name
    Environment = var.environment
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet_name
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_security_group" "main" {
  name = "demo-sg"
  description = "Security group for demo"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demo-sg"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "ssh_inbound" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.allowed_ssh_cidr]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "http_inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.allowed_http_cidr]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "https_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "outbound_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

