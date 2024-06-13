### FUNCAO DO CODIGO ###
# 1 - define os valores das variaveis que serao utilizadas

##################  main.tf  #########################

# declaracao da regiao onde ira ser criado os recursos
region = "sa-east-1"

# variaveis universais
variaveis_universais = {
    criado_com = "terraform"
    dono       = "admin"
    project    = "usado_remote_state"
}

######################################################

##################  network.tf  ######################

# declaracao da cidr_block da vpc
cidr_block_vpc = "10.0.0.0/16"

# nome da vpc
nome_vpc = "vpc-terraform"

# declaracao da cidr_block da subnet
cidr_block_subnet = "10.0.1.0/24"

# declaracao da az da subnet
az_subnet = "sa-east-1a"

# nome da subnet
nome_subnet = "subnet-terraform"

# nome do internet gateway
igw_nome = "igw-terraform"

# declaracao cidr_block da tabela de rota publica
nome_rt_p = "rt-terraform"

# nome do sg
nome_sg = "terraform-sg"

# declaracao da descricao do sg
descricao_sg = "libera o acesso via http e ssh para todos"

# nome da tag do sg
nome_sg_tag = "terraform-sg"

# portas liberadas no sg
portas = [80, 22]

######################################################