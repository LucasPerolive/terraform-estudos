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

##################  vm.tf  ###########################

variable "ami_vm" {
  description = "ami que sera usada para criar a vm"
}

variable "flavor" {
  description = "falvor da vm"
}

variable "nome_vm" {
  description = "nome da vm"
}

######################################################