# Documentação do Projeto Terraform: VPC, Subnet Pública e Instância EC2

![ambiente](ambiente.png)

## 1. Introdução  
Este projeto utiliza o Terraform para provisionar recursos na AWS. Ele cria uma infraestrutura básica para hospedar um site estático em uma instância EC2 dentro de uma VPC.

## 2. Requisitos  
Antes de começar, certifique-se de ter as seguintes ferramentas e recursos disponíveis:
- Terraform
- Conta AWS válida com credenciais configuradas localmente

## 3. Descrição dos Arquivos  
- **main.tf**: Define os recursos da AWS a serem provisionados.
- **rede.tf**: Define a configuração da rede, incluindo VPC, subnets e grupos de segurança.
- **variaveis.tf**: Declara as variáveis utilizadas no projeto; Script para a configuração da instância EC2.
- **ami.tf**: Define a AMI (Amazon Machine Image) da instância EC2.
- **chave-ec2.tf**: Resgata a chave-par que será associada à instância EC2.
- **ec2-ubuntu.tf**: Cria a instância EC2 com o sistema operacional Ubuntu, usada para o servidor.

## 4. Configuração  
Antes de iniciar, ajuste as variáveis necessárias no arquivo `variables.tf` e configure suas credenciais AWS utilizando o comando `aws configure`.

## 5. Execução  
1. Navegue até o diretório do projeto no terminal.
2. Execute `terraform init` para inicializar o diretório.
3. Execute `terraform plan` para visualizar as mudanças planejadas.
4. Execute `terraform apply` para aplicar as mudanças e criar os recursos na AWS.

## 6. Recursos Criados  
- **VPC**: Uma VPC com configurações padrão.
- **Subnet Pública**: Uma subnet pública dentro da VPC.
- **Instância EC2**: Uma instância EC2 com o site estático hospedado.

## 7. Acesso ao Site  
Após a conclusão da implantação, você pode acessar o site através do IP público da instância EC2.

## 8. Limpeza  
Para evitar custos desnecessários, execute `terraform destroy` após a conclusão do uso para remover todos os recursos provisionados.

Esta documentação fornece uma visão geral do projeto e orientações básicas para configurar, executar e gerenciar o projeto Terraform para provisionar uma VPC, subnet pública e uma instância EC2 com um site HTML e CSS. Se houver dúvidas adicionais ou requisitos específicos.
