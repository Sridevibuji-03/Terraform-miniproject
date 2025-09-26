output "public_ec2-public_ip"{
    value = aws_instance.ec2-public1.id
}
output "public_ec2-private_ip"{
    value = aws_instance.ec2-public1.id
}
output "private_ec2-public_ip"{
    value = aws_instance.ec2-private1.id    
}
output "private_ec2-private_ip"{
    value = aws_instance.ec2-private1.id
}