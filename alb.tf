# Terraform AWS Application Load Balancer (ALB)
module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  name               = "nginx-alb"
  load_balancer_type = "application"
  vpc_id             = aws_default_vpc.default.id
  subnets            = [" ", " "]
  security_groups    = [aws_security_group.nginx_sg.id]
  http_tcp_listeners = [
    {
      port               = 8080
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  target_groups = [
    {
      name_prefix      = "pulpo-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      health_check     = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets : [
        {
          target_id : aws_instance.nginx_instance.id,
          port : 8080
        }
      ]
    }
  ]
}
