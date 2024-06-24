terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

# configuracao que define a regiao e variaveis que sera criada em todos os recursos
provider "aws" {
  region = "sa-east-1"
  alias = "america-sul"

  default_tags {
    tags = {criado_com = "provider-america-sul"}
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "america-norte"

  default_tags {
    tags = {criado_com = "provider-america-norte"}
  }
}
