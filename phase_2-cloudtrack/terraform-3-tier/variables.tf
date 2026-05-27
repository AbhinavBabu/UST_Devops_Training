variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr_offset = number
    az_index    = number
    type        = string
  }))
}

variable "bastion_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "app_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "db_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
  }))
}

variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}