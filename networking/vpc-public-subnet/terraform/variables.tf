variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.100.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.100.0.0/24"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type = string
}

variable "ami_id" {
  description = "ID of the Amazon Linux 2 AMI"
  type = string
}