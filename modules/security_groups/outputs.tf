# ALB Security Group ID 출력
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

# ECS Task(API) Security Group ID 출력
output "ecs_task_sg_id" {
  value = aws_security_group.ecs_task_sg.id
}
