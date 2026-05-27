terraform {
    required_providers {
      aws = {
        source = "registry.terraform.io/hashicorp/aws"
        version = "6.44.0"
      }
    }
}

variable "azs" {
    type = list(string)
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "case2-vpc"
    }
}

resource "aws_subnet" "main" {
    count = length(var.azs)
    vpc_id = aws_vpc.main.id 
    cidr_block = cidrsubnet("10.0.0.0/16",4,count.index)
    availability_zone = var.azs[count.index]

    tags = {
        Name = "Subnet ${count.index}"
    }
}

output "subnet_ids" {
  value = aws_subnet.main[*].id
}