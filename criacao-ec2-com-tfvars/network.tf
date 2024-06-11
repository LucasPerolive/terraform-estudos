
#-----------------------------------------------------------------------------------#


# Criação da VPC
resource "aws_vpc" "vpc_site" {
  cidr_block = var.cidr_vpc
  
  tags = {
    Name = var.nome_vpc
  } 
}


#-----------------------------------------------------------------------------------#


# Criação das subnet publicas
resource "aws_subnet" "subnets_publicas" {
  count = length(var.nomes_subnets_publicas)
  vpc_id = aws_vpc.vpc_site.id
  
  map_public_ip_on_launch = true
  cidr_block = element(var.cidrs_subnets_publicas, count.index)
  availability_zone = element(var.zonas, count.index)
  tags = {
    Name = element(var.nomes_subnets_publicas, count.index)
  }
}

# Criação das subnet privadas
resource "aws_subnet" "subnets_privadas" {
  count = length(var.nomes_subnets_privadas)
  vpc_id = aws_vpc.vpc_site.id
  
  cidr_block = element(var.cidrs_subnets_privadas, count.index)
  availability_zone = element(var.zonas, count.index)
  tags = {
    Name = element(var.nomes_subnets_privadas, count.index)
  }
}


#-----------------------------------------------------------------------------------#


# Criação de um internet gateway
resource "aws_internet_gateway" "igw_site" {
  vpc_id = aws_vpc.vpc_site.id

  tags = {
    Name = var.nome_igw
  }
}


#-----------------------------------------------------------------------------------#


# Criação da tabela de rotas publica
resource "aws_route_table" "site_table_publica" {
  vpc_id = aws_vpc.vpc_site.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_site.id
  }
}

# Associação da subnet à tabela de rotas
resource "aws_route_table_association" "publicas" {
  count = length(var.nomes_subnets_publicas)
  subnet_id      = element(aws_subnet.subnets_publicas[*].id, count.index)
  route_table_id = aws_route_table.site_table_publica.id
}

# Criação da tabela de rotas privada
resource "aws_route_table" "site_table_privada" {
  depends_on = [ aws_instance.nat_instance ]
  count = length(var.nomes_subnets_privadas)
  vpc_id = aws_vpc.vpc_site.id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = element(data.aws_network_interface.nat_interface[*].id, count.index)
  }
}

# Associação da subnet à tabela de rotas
resource "aws_route_table_association" "privadas" {
  count = length(var.nomes_subnets_privadas)
  subnet_id      = element(aws_subnet.subnets_privadas[*].id, count.index)
  route_table_id = element(aws_route_table.site_table_privada[*].id, count.index)
}


#-----------------------------------------------------------------------------------#

# Criação de grupos de segurança
resource "aws_security_group" "nat_sg" {
  name        = "nat-sg"
  description = "nat-instance"
  vpc_id      = aws_vpc.vpc_site.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Regras do grupo de segurança projeto



# Criação de grupos de segurança
resource "aws_security_group" "site_sg" {
  count = length(var.nomes_sg)
  name        = element(var.nomes_sg, count.index)
  description = element(var.descricao_sg, count.index)
  vpc_id      = aws_vpc.vpc_site.id
}

# Regras do grupo de segurança projeto
resource "aws_vpc_security_group_ingress_rule" "regras" {
  for_each = { for idx, combo in local.dic_sg_portas : "${combo.sg_name}-${combo.port}-${idx}" => combo }

  security_group_id = aws_security_group.site_sg[each.value.sg_index].id
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = "tcp"
  cidr_ipv4         =  each.value.cidr
}

# Regras de saída
resource "aws_vpc_security_group_egress_rule" "regras" {
  count = length(var.nomes_sg)
  security_group_id = element(aws_security_group.site_sg[*].id, count.index)
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
