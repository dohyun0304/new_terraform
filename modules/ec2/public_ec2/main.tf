resource "aws_instance" "public_instance" {
  for_each = var.instances

  ami           = each.value.ami_id
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  tags = {
    Name        = "${each.value.name}${each.key}"
    Environment = each.value.environment
  }
  vpc_security_group_ids = [aws_security_group.public_security_group.id]

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_eip_association" "public_eip_assoc" {
  for_each = var.instances

  instance_id   = aws_instance.public_instance[each.key].id
  allocation_id = lookup(var.eip_allocation_ids, each.key)
}

resource "aws_security_group" "public_security_group" {
  name        = "public-instance-sg"
  description = "Security group for public instances"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "public_instance_sg_rule" {
  for_each = var.instance_sg_rule

  type        = each.value.type
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.public_security_group.id
}
