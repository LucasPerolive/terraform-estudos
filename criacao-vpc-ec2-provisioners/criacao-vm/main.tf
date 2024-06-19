### FUNCAO DO CODIGO ###
# 1 - define quais serao os pre-requistos
# 2 - define onde sera armazenado os states
# 3 - define a regiao
# 4 - define as variaveis universais
# 5 - regasta o state da vpc

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }

  backend "s3" {
    bucket = "XXXXXXXX"
    key    = "documentacao/criacao-vpc-com-ec2/terraform.tfstate"
    region = "YYYYY"
  }
}

# configuracao que define a regiao e variaveis que sera criada em todos os recursos
provider "aws" {
  region = var.region

  default_tags {
    tags = var.variaveis_universais
  }
}

# chama o state da vpc
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "XXXXXXXX"
    key    = "documentacao/criacao-vpc/terraform.tfstate"
    region = "YYYYY"
  }
}
