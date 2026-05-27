variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "vpc_cidr" {
    type = string 
    default = "10.0.0.0/16"
}
variable "aws_vpc_name" {
    type = string
    default = "demo-vpc"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "subnet_public_cidr" {
    type = string 
    default = "10.0.1.0/24"
}

variable "subnet_private_cidr" {
    type = string 
    default = "10.0.2.0/24"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}