resource "aws_lb" "alb_site" {
  name = var.nome_alb
  load_balancer_type = "application"
  subnets = [
    aws_subnet.subnets_publicas[0].id,
    aws_subnet.subnets_publicas[1].id
    ]
  security_groups = [aws_security_group.site_sg[1].id]
}

resource "aws_lb_target_group" "tg_site" {  
  name = var.nome_tg
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc_site.id
  load_balancing_algorithm_type = "round_robin"
}

resource "aws_lb_target_group_attachment" "conexao_tg_site" {
  count = length(aws_instance.web)
  target_group_arn = aws_lb_target_group.tg_site.arn
  target_id = element(aws_instance.web[*].id, count.index)
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb_site.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_site.arn
  }
}