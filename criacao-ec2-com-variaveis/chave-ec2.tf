# Esse código faz as seguintes ações:
#  1 - Define qual vai ser a par-chave a ser usada

# Nome da chave previamente criada pelo console
data "aws_key_pair" "chave" {
    key_name = var.chave
}