resource "aws_lb" "LoadBalancer" {
  name               = "test-lb-tf"
 
  subnets            = [var.pubSub1ID,var.pubSub2ID]

  security_groups = [ "${aws_security_group.LB-Secrity-Group.id}" ]

  tags = {
    name = "${var.enviromentName} - Load-balancer"
  }
}

resource "aws_lb_target_group" "alb-targetGroup" {
  name        = "tf-example-lb-alb-tg"
  port        = var.lb-port 
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 8
    unhealthy_threshold= 2
  }
}
resource "aws_lb_listener" "LB-Listner" {
  load_balancer_arn = aws_lb.LoadBalancer.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-targetGroup.arn
  }
}




resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = aws_lb_listener.LB-Listner.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-targetGroup.arn
  }

    condition {
    path_pattern {
      values = ["/"]
    }
}
}







resource "aws_security_group" "LB-Secrity-Group" {
  vpc_id      = var.vpc_id

  ingress {
   
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  tags = {
    Name = "${var.enviromentName} -LB-sec-grp"
  }
}

