
resource "aws_security_group" "sg" {
  name        = "${var.resource_prefix}-sg-${var.instance_name}"
  description = "Traffic control for ${var.instance_name}"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each          = var.ingress_ports
  type              = "ingress"
  description       = ""
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress_rules" {
  type              = "egress"
  description       = "outbound traffic"
  from_port         = 0
  protocol          = -1
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_instance" "instances" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id = var.subnet_ids[
    count.index % length(var.subnet_ids)
  ]

  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]

  root_block_device {
    volume_size = 30
  }

  key_name = var.ssh_key_name

  user_data = var.user_data

  tags = {
    Name = "${var.resource_prefix}-${var.instance_name}-${count.index}"
    resource_type = var.instance_name
  }
}