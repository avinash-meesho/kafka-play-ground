
output "sg" {
  value = aws_security_group.sg.name
}

output "public_ip" {
  value = aws_instance.instances.*.public_ip
}

output "private_dns" {
  value = aws_instance.instances.*.private_dns
}
