### FUNCAO DO CODIGO ###
# 1 - define os valores das variaveis que serao utilizadas
# 2 - define a ami da vm
# 3 - define o flavor da vm
# 4 - define o nome da vm

##################  main.tf  #########################

# declaracao da regiao onde ira ser criado os recursos
region = "sa-east-1"

# variaveis universais
variaveis_universais = {
    criado_com = "terraform"
    dono       = "lucas"
    project    = "usado_remote_state"
}

######################################################

##################  vm.tf  ###########################

# define a ami da vm
ami_vm = "ami-04716897be83e3f04"

# define o flavor
flavor = "t2.micro"

# define o nome da instancia
nome_vm = "Terraform-Instance"

######################################################