### FUNCAO DO CODIGO ###
# 1 - saida do id da subnet
# 2 - saida do id da security group


# saida do id da subnet
output "subnet_id" {
  description = "ID da Subnet criada na AWS"
  value       = aws_subnet.subnet_terraform.id
}

# saida do id da security group
output "security_group_id" {
  description = "ID do Security Group criado na AWS"
  value       = aws_security_group.sg_terraform.id
}