### FUNCAO DO CODIGO ###
# 1 - saida do id do ip da maquina
# 2 - saida do id do comando para ssh

# saida do id do ip da maquina
output "vm_ip" {
  description = "IP da VM criada na AWS"
  value = aws_instance.vm.public_ip
}

# saida do id do comando para ssh
output "vm_ssh" {
  description = "IP da VM criada na AWS"
  value = format("ssh -i %s.pem ubuntu@%s", aws_key_pair.key.key_name, aws_instance.vm.public_ip)
}