variable "aws_region" {
  default = "eu-west-2"
  type = string
}

variable "Bastion_name" {
  default = "Bastion-Instance"
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.medium"  
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

