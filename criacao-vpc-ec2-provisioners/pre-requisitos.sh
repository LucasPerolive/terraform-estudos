#!/bin/bash

########################################################
# Cria a chave .pem para o acesso a EC2
mkdir -p ./chaves; cd ./chaves 
sudo ssh-keygen -f aws-key
sudo mv aws-key aws-key.pem
sudo chmod 400 aws-key.pem
cd ..
########################################################

########################################################
# Pega os milesimos e nano segundos para criacao de nome unico do bucket
current_time=$(date +"%S%N")
bucket_name="terraform-state-remote-$current_time"

# Criar o bucket e capturar a saida
output=$(aws s3 mb s3://$bucket_name)

# Extrair apenas o nome do bucket da saida
bucket_name=$(echo $output | grep -oP '(?<=make_bucket: ).*')

# Substituir o nome do bucket nos arquivos main.tf
sed -i "s/\"XXXXXXXX\"/\"$bucket_name\"/g" ./criacao-vm/main.tf
sed -i "s/\"XXXXXXXX\"/\"$bucket_name\"/g" ./criacao-vpc/main.tf
########################################################

########################################################
# pega a regia a qual foi criado o bucket
region=$(aws s3api get-bucket-location --bucket $bucket_name --query "LocationConstraint" --output text)
sed -i "s/\"YYYYY\"/\"$region\"/g" ./criacao-vm/main.tf
sed -i "s/\"YYYYY\"/\"$region\"/g" ./criacao-vpc/main.tf
########################################################

########################################################
# Substituir o nome da chave nos arquivos main.tf
sed -i "s/\"ZZZZZ\"/\"$current_time\"/g" ./criacao-vm/vm.tf
########################################################