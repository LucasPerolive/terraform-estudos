### FUNCAO DO CODIGO ###
# 1 - define quais serao os pre-requistos
# 2 - define onde sera armazenado os states
# 3 - define a regiao
# 4 - define as variaveis universais

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-remote-15299298901"
    key    = "documentacao/criacao-vpc/terraform.tfstate"
    region = "sa-east-1"
  }
}

# configuracao que define a regiao e variaveis que sera criada em todos os recursos
provider "aws" {
  region = var.region

  default_tags {
    tags = var.variaveis_universais
  }
}