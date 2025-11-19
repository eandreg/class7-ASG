# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

# Web ALB Security Group 
resource "aws_security_group" "app_alb_lb" {
  name        = "app-alb-lb"
  description = "Allow traffic from Web LB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "app-alb-sg"
    Tier = "App"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_lb_http" {
  security_group_id = aws_security_group.app_alb_lb.id
  description       = "HTTP from Web LB"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "app_lb_ssh" {
  security_group_id = aws_security_group.app_alb_lb.id
  description       = "SSH from Web LB"
  cidr_ipv4         = "10.130.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "app_lb_egress" {
  security_group_id = aws_security_group.app_alb_lb.id
  description       = "Allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}