### FUNCAO DO CODIGO ###
# 1 - define qual a chave que sera usada
# 2 - cria a instancia


# define qual a chave que sera usada
resource "aws_key_pair" "key" {
  key_name = "aws_key-15299298901"
  public_key = file("../chaves/aws-key.pub")
}

# cria a instancia
resource "aws_instance" "vm" {
  ami = var.ami_vm
  instance_type = var.flavor
  key_name = aws_key_pair.key.key_name

  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  # cria uma arquivo local com o IP publico da ec2
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }

  # conecta com a ec2 via ssh
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./aws-key.pem")
    host = self.public_ip
  }

  # executa os comandos
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt-get install apache2 -y",
      "echo '<h1>teste</h1>' >> index.html",
      "sudo rm /var/www/html/index.html",
      "sudo cp index.html /var/www/html/index.html"
    ]
  }

  # faz uma copia do arquivo local para a ec2
  provisioner "file" {
    source = "./arquivo.txt"
    destination = "/tmp/arquivo-teste.txt"
  }

  # faz um "echo" para a ec2
  provisioner "file" {
    content = "ami usada: ${self.ami}"
    destination = "/tmp/ami-usada.txt"
  }

  tags = {
    Name = var.nome_vm
  }
}