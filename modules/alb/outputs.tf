# ALB DNS 이름 출력
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

# ALB 리스너 모듈의 output.tf
output "alb_listener_arn" {
  value = aws_lb_listener.alb_listener.arn
}

# ALB Target Group ARN 출력
output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}
