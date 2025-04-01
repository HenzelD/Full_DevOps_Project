resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform_key"
  public_key = file("terraform_key.pub")
}
