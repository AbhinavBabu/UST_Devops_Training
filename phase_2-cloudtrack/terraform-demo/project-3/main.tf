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
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = var.aws_vpc_name
        Environment = var.environment
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    
    tags = {
        Name = "demo4-igw"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_public_cidr
    availability_zone = var.availability_zone
    

    tags = {
        Name = "public-sub"
        Type = "public"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_private_cidr
    availability_zone = var.availability_zone

    tags = {
        Name = "private-sub"
        type = "private"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "public-rt"    
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id 

    tags = {
        Name = "private-rt" 
    }
}


resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id 
    route_table_id = aws_route_table.public.id 
}

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id 
}

resource "aws_security_group" "public" {
    vpc_id = aws_vpc.main.id
    name = "public-sg"
    description = "sg for public ec2"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo4-public-sg"
  }
}

resource "aws_security_group" "private" {
  name        = "demo4-private-sg"
  description = "Security group for private resources"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo4-private-sg"
  }

}