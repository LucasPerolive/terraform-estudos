# região para a criação dos recursos
region      = "sa-east-1"

# nome e escopo de rede da VPC
nome_vpc = "vpc-site"
cidr_vpc = "192.168.0.0/16"

# nome do internet gateway
nome_igw = "igw_site"

# nomes e escopos de rede das subnets
nomes_subnets_publicas = ["rede_publica_1a", "rede_publica_1b"]
cidrs_subnets_publicas = ["192.168.2.0/25", "192.168.4.0/24"]

nomes_subnets_privadas = ["rede_privada_1a", "rede_privada_1b"]
cidrs_subnets_privadas = ["192.168.1.0/24", "192.168.3.0/24"]

# zonas que os recursos serão criados
zonas = ["sa-east-1a", "sa-east-1b"]

# nomes dos grupos de segurança
nomes_sg = ["ssh-bastion", "web-alb", "access-alb-ec2"]
descricao_sg = [
  "libera o acesso para o bastion via ssh", 
  "libera o acesso http e https para o alb",
  "libera o acesso para a ec2 pelo bastion na porta 22"
  ]
portas_sg = [[22], [80, 443], [22]]
origem_sg = [["177.235.146.210/32"], ["0.0.0.0/0"], ["192.168.0.0/16"]]

# ami da amazon-linux
amazon_linux = "ami-0d2b872bd98d125e5"

flavor = "t3.nano"

nome_aplicacao = ["app-1a", "app-1b"]

nome_alb = "alb-site"

nome_tg = "tg-site"

nat-instance = ["nat-instance-1a", "nat-instance-1b"]
