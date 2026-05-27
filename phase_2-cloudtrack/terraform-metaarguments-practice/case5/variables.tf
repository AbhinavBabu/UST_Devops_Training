variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "my-app"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    port        = number
    protocol    = string
    description = string
    cidr        = string
  }))
  default = [
    {
      port        = 80
      protocol    = "tcp"
      description = "Allow HTTP traffic"
      cidr        = "0.0.0.0/0"
    },
    {
      port        = 443
      protocol    = "tcp"
      description = "Allow HTTPS traffic"
      cidr        = "0.0.0.0/0"
    },
    {
      port        = 22
      protocol    = "tcp"
      description = "Allow SSH from office"
      cidr        = "203.0.113.0/24"
    },
    {
      port        = 3306
      protocol    = "tcp"
      description = "Allow MySQL from internal network"
      cidr        = "10.0.0.0/16"
    }
  ]
}
