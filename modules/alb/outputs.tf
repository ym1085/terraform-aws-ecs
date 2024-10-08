# ALB DNS 이름 출력
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

# ALB Target Group ARN 출력
output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}
