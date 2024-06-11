resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.flavor
  subnet_id = aws_subnet.subnets_publicas[1].id
  security_groups = [
    aws_security_group.site_sg[0].id
  ]
  key_name = data.aws_key_pair.chave.key_name

  tags = {
    Name = "bastion"
  }
}