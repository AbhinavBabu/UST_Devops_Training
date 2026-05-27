variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "aws_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "aws_vpc_name" {
  type = string
  default = "test-vpc"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "subnet_name" {
  type = string
  default = "main-subnet"
}
variable "availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "igw_name" {
  type = string
  default = "main-igw"
}

variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  type    = string
  default = "0.0.0.0/0"
}