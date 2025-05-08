variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones for public subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]

}

variable "instance_type" {
  description = "Instance type for the EC2 launch template"
  type        = string
  default     = "t2.micro"
}



variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH (port 22)"
  type        = string
  default     = "107.196.215.206/32"
}


