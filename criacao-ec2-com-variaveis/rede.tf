# Esse código faz as seguintes ações:
#  1 - Cria uma VPC
#  2 - Cria uma subnet
#  3 - Cria um gateway de internet e associa
#  4 - Cria uma tabela de rotas
#  5 - Associa a subnet à tabela de rotas
#  6 - Cria um grupo de segurança
#  7 - Regras do grupo de segurança


# Criação da VPC
resource "aws_vpc" "projeto" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-projeto"
  }
}

# Criação da subnet
resource "aws_subnet" "projeto" {
  vpc_id            = aws_vpc.projeto.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subrede-publica-1a"
  }
}

# Criação do gateway de internet e associa
resource "aws_internet_gateway" "projeto" {
  vpc_id = aws_vpc.projeto.id

  tags = {
    Name = "igw-projeto"
  }
}

# Criação da tabela de rotas
resource "aws_route_table" "projeto" {
  vpc_id = aws_vpc.projeto.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.projeto.id
  }
}

# Associação da subnet à tabela de rotas
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.projeto.id
  route_table_id = aws_route_table.projeto.id
}

resource "aws_security_group" "projeto" {
  name        = "projeto-sg"
  description = "Permite o acesso SSH HTTP e HTTPS"
  vpc_id      = aws_vpc.projeto.id
}

# Regras do grupo de segurança projeto
resource "aws_vpc_security_group_ingress_rule" "regra-1-entrada" {
  security_group_id = aws_security_group.projeto.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.meu-ip
}
resource "aws_vpc_security_group_ingress_rule" "regra-2-entrada" {
  security_group_id = aws_security_group.projeto.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = var.meu-ip
}
resource "aws_vpc_security_group_ingress_rule" "regra-3-entrada" {
  security_group_id = aws_security_group.projeto.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = var.meu-ip
}

resource "aws_vpc_security_group_egress_rule" "regra-1-saida" {
  security_group_id = aws_security_group.projeto.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}