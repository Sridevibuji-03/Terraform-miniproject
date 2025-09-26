resource "aws_security_group" "sg1" {
  name        = "${var.project_name}-sg"
  vpc_id      = aws_vpc.vpc1.id

  tags = {
    Name = "${var.project_name}-sg"
    Managed_by = "${var.managed_by}"
  }
 ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
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
    ipv6_cidr_blocks = ["::/0"]
  }

}

