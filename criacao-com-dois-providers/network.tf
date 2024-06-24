resource "aws_vpc" "vpc-us" {
  cidr_block = "192.168.1.0/24"
  provider = aws.america-norte
}

resource "aws_vpc" "vpc-sa" {
  cidr_block = "10.0.0.0/24"
  provider = aws.america-sul
}
