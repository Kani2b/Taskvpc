variable "aws_region" {
 description = "The region where AWS resources will be created"
 default = "eu-north-1"
}

variable "ami_id" {
  description = "The ID of the  AMI to use for EC2 instances"
  default     = "ami-0ea7dc624e77a15d5" 
}

variable "key_name" {
 description = "Name of the SSH key for EC2 instances"
 default = "terra-key"
}

variable "subnet_cidr" {
  description = "CIDR block for the RDS subnet group"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "instance_type" {
 description  = "Type of Instance"
 default = "t3.micro"
}
