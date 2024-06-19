### FUNCAO DO CODIGO ###
# 1 - define quais serao as variaveis usadas 

##################  main.tf  #########################

# descricao da variavel region
variable "region" {
  description = "regiao onde sera criado os recursos"
}

# variavies universais
variable "variaveis_universais" {
  description = "lista de variaveis universais"
}

######################################################

##################  network.tf  ######################

# descricao do cidr_block da vpc
variable "cidr_block_vpc" {
  description = "cidr da vpc"
}

# descricao do nome da vpc
variable "nome_vpc" {
  description = "vpc-terraform"
}

# decricao do cidr_block da subnet
variable "cidr_block_subnet" {
  description = "cidr da subnet"
}

# descricao da az da subnet
variable "az_subnet" {
  description = "az da subnet"
}

# descricao do nome da subnet
variable "nome_subnet" {
  description = "subnet-terraform"
}

# descricao do nome da subnet
variable "igw_nome" {
  description = "nome do internet gateway"
}



# descricao do nome da subnet
variable "nome_rt_p" {
  description = "nome da tabela de rota publica"
}

# nome do sg
variable "nome_sg" {
  description = "nome do sg"
}

# nome do sg por tag
variable "nome_sg_tag" {
  description = "nome dada a tag do sg"
}

# descricao do sg
variable "descricao_sg" {
  description = "descricao do grupo de seguranca"
}

# portas do sg
variable "portas" {
  description = "portas liberadas para o acesso"
}

######################################################