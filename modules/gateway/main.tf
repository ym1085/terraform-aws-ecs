# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.domain}-igw-${var.environment}"
  }
}

# NAT 게이트웨이에서 사용할 EIP 생성
resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.gw] # IGW가 생성된 후 EIP 생성 가능
}

# NAT 게이트웨이 생성
resource "aws_nat_gateway" "gw" {
  subnet_id     = var.public_subnet_id
  allocation_id = aws_eip.nat.id
}
