terraform{
    required_providers {
      aws = {
        source = "registry.terraform.io/hashicorp/aws"
        version = "6.44.0"
      }
    }
}

variable "aws_region" {
    type = string 
    default = "us-east-1"
}
provider "aws" {
    region = var.aws_region
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "test-vpc"
    }
}