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