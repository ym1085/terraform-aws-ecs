# ALB Security Group 생성
resource "aws_security_group" "alb_sg" {
  name        = "${var.domain}-alb-sg-${var.environment}"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {                             # 인바운드 규칙 추가
    protocol    = "tcp"                 # 프로토콜 타입
    from_port   = var.alb_listener_port # 포트 범위
    to_port     = var.alb_listener_port # 포트 범위
    cidr_blocks = ["0.0.0.0/0"]         # 소스 CIDR
  }

  egress {                      # 아웃바운드 규칙 추가
    protocol    = "-1"          # 프로토콜 타입
    from_port   = 0             # 포트 범위
    to_port     = 0             # 포트 범위
    cidr_blocks = ["0.0.0.0/0"] # 소스 CIDR
  }
}

# ECS Task(API) Security Group 생성
resource "aws_security_group" "ecs_task_sg" {
  name        = "${var.environment}-ecs-task-sg"
  description = "Security group for ecs task"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
