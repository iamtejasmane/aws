output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value = aws_subnet.public.id
}

output "instance_public_ip" {
  description = "Public IP of the instance"
  value = aws_instance.main.public_ip
}