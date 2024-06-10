# Esse código faz as seguintes ações:
#  1 - Cria uma VPC
#  2 - Cria uma subnet
#  3 - Cria um gateway de internet e associa
#  4 - Cria uma tabela de rotas
#  5 - Associa a subnet à tabela de rotas
#  6 - Cria um grupo de segurança
#  7 - Regras do grupo de segurança


# Criação da VPC
resource "aws_vpc" "projeto-vpc" {
  cidr_block = var.ip-vpc

  tags = {
    Name = "vpc-projeto"
  }
}

# Criação da subnet
resource "aws_subnet" "projeto-subnet-1" {
  vpc_id            = aws_vpc.projeto-vpc.id
  cidr_block        = var.ip-subnet-1
  availability_zone = var.AZ1
  map_public_ip_on_launch = true

  tags = {
    Name = "subrede-publica-1a"
  }
}

# Criação do gateway de internet e associa
resource "aws_internet_gateway" "projeto-igw" {
  vpc_id = aws_vpc.projeto-vpc.id

  tags = {
    Name = "igw-projeto"
  }
}

# Criação da tabela de rotas
resource "aws_route_table" "projeto-table" {
  vpc_id = aws_vpc.projeto-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.projeto-igw.id
  }
}

# Associação da subnet à tabela de rotas
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.projeto-subnet-1.id
  route_table_id = aws_route_table.projeto-table.id
}

resource "aws_security_group" "projeto-sg" {
  name        = "projeto-sg"
  description = "Permite o acesso SSH HTTP e HTTPS"
  vpc_id      = aws_vpc.projeto-vpc.id
}

# Regras do grupo de segurança projeto
resource "aws_vpc_security_group_ingress_rule" "regra-1-entrada" {
  security_group_id = aws_security_group.projeto-sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.meu-ip
}
resource "aws_vpc_security_group_ingress_rule" "regra-2-entrada" {
  security_group_id = aws_security_group.projeto-sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = var.permissivo-ip
}
resource "aws_vpc_security_group_ingress_rule" "regra-3-entrada" {
  security_group_id = aws_security_group.projeto-sg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = var.permissivo-ip
}

resource "aws_vpc_security_group_egress_rule" "regra-1-saida" {
  security_group_id = aws_security_group.projeto-sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.permissivo-ip
}
