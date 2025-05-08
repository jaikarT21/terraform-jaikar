resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-my-ip" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = var.allowed_ssh_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
 to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow-all-outbound-traffic" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

