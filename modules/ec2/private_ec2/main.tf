resource "aws_instance" "private_instance" {
  for_each = var.instances

  ami           = each.value.ami_id
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  tags = {
    Name        = "${each.value.name}${each.key}"
    Environment = each.value.environment
  }
  vpc_security_group_ids = [aws_security_group.private_security_group.id]

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_security_group" "private_security_group" {
  name        = "private-instance-sg"
  description = "Security group for private instances"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "private_instance_sg_rule" {
  for_each = var.instance_sg_rule

  type        = each.value.type
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.private_security_group.id
}
