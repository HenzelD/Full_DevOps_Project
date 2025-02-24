module "Bastion_EC2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = var.Bastion_name
  ami = data.aws_ami.ec2linux.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  vpc_security_group_ids = [module.Bastion_SG.security_group_id]
  tags = var.Bastion_tag
}