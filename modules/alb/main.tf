# ALB 생성
resource "aws_lb" "alb" {
  name               = "${var.domain}-alb-${var.environment}"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]
}

# ALB Target Group 생성
resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.domain}-tg-${var.environment}"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" # ecs fargate의 경우 ip 타입으로 설정 필요
}

# ALB Listener 생성
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
