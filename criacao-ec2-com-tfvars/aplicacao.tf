

resource "aws_instance" "web" {
  count = length(var.nome_aplicacao)
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.flavor
  subnet_id = element(aws_subnet.subnets_privadas[*].id, count.index)
  security_groups = [
    aws_security_group.site_sg[1].id,
    aws_security_group.site_sg[2].id
  ]
  key_name = data.aws_key_pair.chave.key_name

  tags = {
    Name = element(var.nome_aplicacao, count.index)
  }

  user_data = local.script
}