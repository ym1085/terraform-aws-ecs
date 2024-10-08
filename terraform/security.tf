# security.tf

# ALB 보안 그룹 생성
resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group" # 보안 그룹 이름
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id # 보안그룹이 속한 VPC 지정

  ingress {                            # 인바운드 트래픽
    protocol    = "tcp"                # 인바운드 트래픽은 TCP 타입
    from_port   = var.application_port # 트래픽 시작 포트
    to_port     = var.application_port # 트래픽 종료 포트
    cidr_blocks = ["0.0.0.0/0"]        # 트래픽 소스 IP 범위
  }

  egress {                      # 아웃바운드 트래픽
    protocol    = "-1"          # 모든 프로토콜에 대해 나가는 트래픽 허용
    from_port   = 0             # 모든 포트에서 나가는 트래픽을 허용
    to_port     = 0             # 모든 포트에서 나가는 트래픽을 허용
    cidr_blocks = ["0.0.0.0/0"] # 모든 IP에서 나가는 트래픽을 허용
  }
}

# ECS 보안 그룹 생성
resource "aws_security_group" "ecs_task_sg" {
  name        = "ecs_task_security_group"
  description = "Security group for ecs task"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = var.application_port
    to_port     = var.application_port
    cidr_blocks = [aws_security_group.alb_sg.id] # ALB 보안 그룹에서 오는 트래픽만 허용
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
