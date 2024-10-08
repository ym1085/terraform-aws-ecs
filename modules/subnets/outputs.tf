# Public Subnet ID 출력
output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

# Private Subnet ID 출력
output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}
