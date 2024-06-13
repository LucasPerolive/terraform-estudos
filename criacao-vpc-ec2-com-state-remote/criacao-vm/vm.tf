### FUNCAO DO CODIGO ###
# 1 - define qual a chave que sera usada
# 2 - cria a instancia


# define qual a chave que sera usada
resource "aws_key_pair" "key" {
  key_name = "aws_key-XXXXXXXX"
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

  tags = {
    Name = var.nome_vm
  }
}