#public ec2
resource "aws_instance" "ec2-public1" {
    ami                         = "ami-0e742cca61fb65051"
    instance_type               = var.instance_name
    subnet_id                   = aws_subnet.public_subnet1.id
    key_name                    = "terraform-poc-public-key"
    associate_public_ip_address = "true"
    vpc_security_group_ids      = [aws_security_group.sg1.id]

tags = {
    Name = "${var.project_name}-ec2_public1"
    Managed_by = "${var.managed_by}"
  }
}

#private ec2
resource "aws_instance" "ec2-private1" {
    ami                         = "ami-0e742cca61fb65051"
    instance_type               = var.instance_name
    subnet_id                   = aws_subnet.private_subnet1.id
    key_name                    = "terraform-poc-public-key"
    vpc_security_group_ids      = [aws_security_group.sg1.id]

iam_instance_profile            = aws_iam_instance_profile.private_ec2_profile.name   

tags = {
    Name = "${var.project_name}-ec2_private1"
    Managed_by = "${var.managed_by}"
  }
}