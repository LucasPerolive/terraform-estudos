# Esse código faz as seguintes ações:
#  1 - Cria a variável com a região
#  2 - Cria a variável com o escopo de rede da VPC
#  3 - Cria a variável com o escopo de rede da subnet
#  4 - Cria a variável com a zona que será criada a subnet
#  5 - Cria a variável com o meu ip público
#  6 - Cria a variável com o flavor da máquina
#  7 - Cria a variável com a chave-par será usada
#  8 - Cria o script para instalar o apache e importar a página web do git

# Variável com o valor da região
variable "region" {
  type        = string
  description = "Regiao que ira ser usada na aws"
  default     = "sa-east-1"
}

# Define o escopo de rede da VPC
variable "ip-vpc" {
    type = string
    description = "IP da VPC"
    default = "10.0.0.0/16"
}

# Define o escopo de rede da subnet
variable "ip-subnet-1" {
  type = string
  description = "Ip da subnet publica"
  default = "10.0.1.0/24"
}

# Define a zona que será criada a subnet
variable "AZ1" {
  type = string
  description = "Define a zona 1a"
  default = "sa-east-1a"
}

# Variável com o valor do ip do meu ip público
variable "meu-ip" {
    type = string
    description = "Meu IP para fazer o acesso"
    default = "201.40.57.206/32"
}

# Variável com o IP mais permissivo
variable "permissivo-ip" {
    type = string
    description = "Meu IP para fazer o acesso"
    default = "0.0.0.0/0"
}

# Define o flavor da máquina
variable "flavor" {
  type = string
  description = "Define o falvor da instância"
  default = "t2.micro"
}

# Define qual chave-par será usada
variable "chave" {
    type = string
    description = "Chave-par que será usada"
    default = "chave_de_acesso"
}

# Script para instalar o apache e importar a página web do git
locals {
    script = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt-get install apache2 -y
        sudo rm /var/www/html/index.html
        sudo git clone https://github.com/LucasPerolive/exemplo-web.git
        sudo mv ./exemplo-web/* /var/www/html/
        systemctl restart apache2
    EOF
}
