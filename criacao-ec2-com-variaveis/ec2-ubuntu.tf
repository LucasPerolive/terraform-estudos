# Esse código faz as seguintes ações:
#  1 - Cria um servidor web usando uma EC2
#  2 - Saída do IP público do servidor web

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.flavor
  subnet_id = aws_subnet.projeto-subnet-1.id
  security_groups = [
    aws_security_group.projeto-sg.id
  ]
  key_name = data.aws_key_pair.chave.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Web"
  }

  user_data = local.script
}

output "ip" {
  value = format(aws_instance.web.public_ip)
}
