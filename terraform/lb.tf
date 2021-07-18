# =================================
# ALB
# =================================
resource "aws_lb" "api_alb" {
  name               = "api-alb-tf"
  internal           = fasle
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.sg.id
  ]
  subnets = data.aws_subnet.public_subnet.id

}


# =================================
# ALB Listener
# =================================
resource "aws_lb_listener" "forward_alb" {
  load_balancer_arn = aws_lb.api_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg.arn
  }
}

resource "aws_lb_listener" "forward_api" {
  load_balancer_arn = aws_lb.api-alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg.arn
  }
}


# =================================
# ALB Target Group
# =================================
resource "aws_lb_target_group" "api_tg" {
  name     = api
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.my-vpc.id
}

# =================================
# NLB attachment
# =================================
resource "aws_lb_target_group_attachment" "attach_api" {
  target_group_arn = aws_lb_target_group.api_tg.arn
  target_id        = element(aws_instance.API.*.id, count.index)
  port             = 8080
  count            = "1"
}