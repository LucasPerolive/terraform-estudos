mplo# Esse código faz as seguintes ações:
#  1 - Cria a variável com a região
#  2 - Cria a variável com o meu ip público
#  3 - Cria o script para instalar o apache e importar a página web do git

# Variável com o valor da região
variable "region" {
  type        = string
  description = "Regiao que ira ser usada na aws"
  default     = "sa-east-1"
}

# Variável com o valor do ip do meu ip público
variable "meu-ip" {
    type = string
    description = "Meu IP para fazer o acesso"
    default = "201.40.57.206/32"
}

# Script para instalar o apache e importar a página web do git
locals {
    script = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt-get install apache2 -y
        sudo rm /var/www/html/index.html
        sudo git clone https://github.com/LucasPerolive/exemplo-web.git
        sudo mv ./exemplo-web/pagina/* /var/www/html/
        systemctl restart apache2
    EOF
}
