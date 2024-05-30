resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.aurora_cluster_identifier
  engine                  = "aurora-mysql"
  engine_version          = var.aurora_engine_version
  master_username         = var.aurora_master_username
  master_password         = var.aurora_master_password
  database_name           = var.aurora_database_name
  backup_retention_period = var.aurora_backup_retention_period
  preferred_backup_window = var.aurora_preferred_backup_window
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  tags = {
    Name = var.aurora_cluster_identifier
  }
}

resource "aws_rds_cluster_instance" "this" {
  count                = var.aurora_instance_count
  identifier           = "${var.aurora_cluster_identifier}-${count.index}"
  cluster_identifier   = aws_rds_cluster.this.id
  instance_class       = var.aurora_instance_class
  engine               = aws_rds_cluster.this.engine
  engine_version       = aws_rds_cluster.this.engine_version
  db_subnet_group_name = aws_db_subnet_group.this.name

  tags = {
    Name = "${var.aurora_cluster_identifier}-${count.index}"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = var.aurora_db_subnet_group_name
  subnet_ids = var.aurora_subnet_ids

  tags = {
    Name = var.aurora_db_subnet_group_name
  }
}

resource "aws_security_group" "aurora_sg" {
  name        = "${var.aurora_cluster_identifier}-sg"
  description = "Aurora Security Group"
  vpc_id      = var.aurora_vpc_id

  ingress {
    from_port   = var.aurora_ingress_port
    to_port     = var.aurora_ingress_port
    protocol    = "tcp"
    cidr_blocks = var.aurora_ingress_cidr_blocks
  }

  dynamic "egress" {
    for_each = var.aurora_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.aurora_cluster_identifier}-sg"
  }
}
