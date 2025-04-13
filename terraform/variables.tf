#VPC
variable "vpc_name" {
  default = "full_devops_proj"
  type = string
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type = string
}

variable "vpc_az" {
  default = ["eu-west-2a", "eu-west-2b"]
  type = list(string)
}

variable "vpc_public_subnets" {
  default = ["192.168.1.0/24", "192.168.2.0/24"]
  type = list(string)
}

variable "vpc_private_subnets" {
  default = ["192.168.11.0/24", "192.168.12.0/24"]
  type = list(string)
}

variable "aws_region" {
  default = "eu-west-2"
  type = string
}

variable "Bastion_name" {
  default = "Bastion-Instance"
  type = string
}

variable "EC2-Private_name" {
default = "CV"
type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"  
}

variable "instance_keypair" {
  type = string
  default = "terraform_key"
}

variable "Bastion_tag" {
  type = map(string)
  default = {
    Name  = "Bastion"
    Owner = "Dominik"
  }
}

variable "Private_tag" {
  type = map(string)
  default = {
    Name  = "CV"
    Owner = "Dominik"
  }
}

variable "Private2_tag" {
  type = map(string)
  default = {
    Name  = "EN_CV"
    Owner = "Dominik"
  }
}


variable "Elb_tag" {
  type = map(string)
  default = {
    Name  = "Load Balancer"
    Owner = "Dominik"
  }
}

variable "Elb_name" {
  default = "DominikHenzelCV"
  type = string
}
