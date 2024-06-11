variable "region" {
  description = "Regiao para a criação das variaveis"
}

variable "nome_vpc" {
    description = "Nome da VPC"
}

variable "cidr_vpc" {
    description = "CIDR da VPC"
}

variable "nomes_subnets_publicas" {
  description = "Nomes das subredes publicas"
}

variable "cidrs_subnets_publicas" {
  description = "CIDRs das subredes publicas"
}

variable "nomes_subnets_privadas" {
  description = "Nomes das subredes privadas"
}

variable "cidrs_subnets_privadas" {
  description = "CIDRs das subredes privadas"
}

variable "zonas" {
  description = "Zonas de criação"
}

variable "nome_igw" {
  description = "Gateway de internet"
}

variable "nomes_sg" {
  description = "Nome dos grupos de segurança"
}

variable "descricao_sg" {
  description = "Descrição dos grupos"
}

variable "portas_sg" {
  description = "Portas do grupos de segurança"
}

variable "origem_sg" {
  description = "Origens dos gupos"
}

variable "amazon_linux" {
  description = "AMI da amazon 2"
}

variable "flavor" {
  description = "Flavor das máquinas"
}

variable "nome_aplicacao" {
  description = "nome das máquinas de aplicação"
}

variable "nat-instance" {
  description = "nome das nat-instance"
}

variable "nome_alb" {
  description = "Nome do site do alb"
}

variable "nome_tg" {
  description = "Nome do Target group"
}

locals {
  dic_sg_portas = flatten([
    for idx, sg in var.nomes_sg : [
      for port_idx, port in var.portas_sg[idx] : [
        for cidr_idx, cidr in var.origem_sg[idx] : {
          sg_name   = sg
          port      = port
          cidr      = cidr
          sg_index  = idx
        }
      ]
    ]
  ])
}

data "aws_ami" "ubuntu" {
  # Seleciona a mais recente que atenda as exigencias
  most_recent = true
  owners = ["099720109477"] # Pertence a Canonical

  # Criterios de pesquisa para a AMI
  filter {
    # Procura AMI que atende o nome definido
    name   = "name"

    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  # Criterios de pesquisa para a AMI
  filter {
    # Procura AMI que atende a arquitetura definida
    name   = "virtualization-type" # Tipo de virtualizacao
    values = ["hvm"] # Hardware Virtual Machine
  }
}

data "aws_network_interface" "nat_interface" {
  count = length(var.nomes_subnets_privadas)
  filter {
    name   = "attachment.instance-id"
    values = [aws_instance.nat_instance[count.index].id]
  }
}

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

locals {
  script_nat = <<-EOF
        #!/bin/bash 
        # Amazon Linux NAT Instance User Data 
        VPC=192.168.0.0/16 
        ### Enabling IP Forwarding permanently 
        echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf 
        sysctl -p 
        ### Setup IPTables 
        yum install iptables-services -y 
        iptables -t nat -A POSTROUTING -s $VPC -j MASQUERADE 
        iptables-save > /etc/sysconfig/iptables 
        systemctl enable iptables 
        systemctl restart iptables 
  EOF
}
