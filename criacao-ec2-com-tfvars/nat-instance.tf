resource "aws_instance" "nat_instance" {
  count = length(var.nat-instance)
  ami           = var.amazon_linux
  instance_type = var.flavor
  subnet_id = element(aws_subnet.subnets_publicas[*].id, count.index)
  security_groups = [
    aws_security_group.nat_sg.id
  ]
  key_name = data.aws_key_pair.chave.key_name
  source_dest_check = false

  tags = {
    Name = element(var.nat-instance, count.index)
  }

  user_data = local.script_nat
}