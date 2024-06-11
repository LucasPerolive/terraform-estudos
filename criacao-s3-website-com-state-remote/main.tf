# Configurações do Terraform
terraform {
  # Versão requerida do terraform
  required_version = ">= 1.3.0"

  # Versão requerida do provedor
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }

  backend "s3" {
    bucket = "state-terraform-perolive"
    key = "documentacao/state.tfstate"
    region = "sa-east-1"
  }
}

# Configuração do provedor
provider "aws" {
  region = "sa-east-1"

  # Tags que serão adicionadas em todos os recursos
  default_tags {
    tags = {
      ambiente   = "desenvolvimento"
      criado-por = "terraform"
    }
  }
}
