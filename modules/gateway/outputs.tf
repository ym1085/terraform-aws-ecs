# 인터넷 게이트웨이 ID 출력
output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}

# NAT 게이트웨이 ID 출력
output "nat_gateway_id" {
  value = aws_nat_gateway.gw.id
}
