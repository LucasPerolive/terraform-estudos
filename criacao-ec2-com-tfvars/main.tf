terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

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
