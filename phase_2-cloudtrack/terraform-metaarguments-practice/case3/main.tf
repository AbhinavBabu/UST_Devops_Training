terraform {
    required_providers {
      aws = {
        source = "registry.terraform.io/hashicorp/aws"
        version = "6.44.0"
      }
    }
}

variable "region_amis" {
    type = map(string)
    default = {
        "us-east-1" = "ami-091138d0f0d41ff90"
        "ap-south-1" = "ami-07a00cf47dbbc844c"
    }
}

variable "region" {
    type = string
    default = "us-east-1"
}

provider "aws" {
    region = var.region 
}

data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../case2/terraform.tfstate"
    }
}

resource "aws_instance" "sample-ec2" {
    subnet_id = data.terraform_remote_state.network.outputs.subnet_ids[0]
    ami = var.region_amis[var.region]
    instance_type = "t2.micro"

    tags = {
        Name = "sample-ec2"
    }
}

