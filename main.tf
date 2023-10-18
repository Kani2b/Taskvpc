resource "aws_vpc" "task_vpc" {
 cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private_subnet" {
 vpc_id     = aws_vpc.task_vpc.id
 cidr_block = var.subnet_cidr[0]
 availability_zone = "eu-north-1a"
 map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet" {
 vpc_id     = aws_vpc.task_vpc.id
 cidr_block = var.subnet_cidr[1]
 availability_zone = "eu-north-1b"
 map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet2" {
 vpc_id     = aws_vpc.task_vpc.id
 cidr_block = var.subnet_cidr[2]
 availability_zone = "eu-north-1c"
 map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gate" {
  vpc_id = aws_vpc.task_vpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.task_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gate.id
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "EC2 security group"
  vpc_id      = aws_vpc.task_vpc.id
}

resource "aws_instance" "public_ec2" {
 ami = var.ami_id
 instance_type = var.instance_type
 subnet_id = aws_subnet.public_subnet.id
 key_name = var.key_name
}

resource "aws_instance" "private_ec2" {
 ami = var.ami_id
 instance_type = var.instance_type
 subnet_id = aws_subnet.private_subnet.id
 key_name = var.key_name
}
