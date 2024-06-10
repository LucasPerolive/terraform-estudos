# Esse código faz as seguintes ações:
#  1 - Define a versão do Terraform e do provedor
#  2 - Configura o provedor AWS


# Versão do Terraform e provedor
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

# Configuração do provider AWS
provider "aws" {
  region = var.region

  # Tags que serão adicionadas em todos os recursos
  default_tags {
    tags = {
      ambiente   = "desenvolvimento"
      criado-por = "terraform"
    }
  }
}
