# Public Subnet A zone 출력
output "public_subnet_id" {
  value = aws_subnet.public[0].id
}

# Public Subnet ID 출력
output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

# Private Subnet ID 출력
output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}
