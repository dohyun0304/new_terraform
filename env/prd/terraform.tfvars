aws_access_key = ""
aws_secret_key = ""
aws_region     = "ap-northeast-2"
terraform   = "true"
#####################VPC#####################
vpc_cidr = "10.0.0.0/16"
vpc_name = "Project VPC"

public_subnets = {
  subnet1 = { cidr = "10.0.101.0/24", az = "ap-northeast-2a" },
  subnet2 = { cidr = "10.0.102.0/24", az = "ap-northeast-2b" }
  #subnet3= {cidr = "10.0.103.0/24", az = "ap-northeast-2c"}
}

private_subnets = {
  subnet1 = { cidr = "10.0.201.0/24", az = "ap-northeast-2a" },
  subnet2 = {cidr= "10.0.202.0/24", az= "ap-northeast-2b"},
  #  subnet3={cidr= "10.0.203.0/24", az= "ap-northeast-2c"}
}

node_subnets = {
  subnet1 = { cidr = "10.0.10.0/24", az = "ap-northeast-2a" }
  subnet2 = { cidr = "10.0.20.0/24", az = "ap-northeast-2c" }
  #  subnet3={cidr= "10.0.103.0/24", az= "ap-northeast-2c"}
}

enable_nat_gateway = true
enable_vpn_gateway = true

public_route_cidrs = { #igw 추가
  subnet1 = ["0.0.0.0/0"]
  subnet2 = ["0.0.0.0/0"]
}

node_route_cidrs = "0.0.0.0/0"

public_instance_sg_rule = {
  instance1 = [
    {
      type        = "egress"
      from_port   = 2022
      to_port     = 2022
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

private_instance_sg_rule = {
  instance1 = [
    {
      type        = "ingress"
      from_port   = 2022
      to_port     = 2002
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


#####################EC2#####################
public_instance_count  = 1
private_instance_count = 1

public_ami_id  = "ami-0c9c942bd7bf113a2"
private_ami_id = "ami-0c9c942bd7bf113a2"

public_instance_type  = "t2.micro"
private_instance_type = "t2.micro"

public_name  = "public-instance"
private_name = "private-instance"

environment = "prod"

#####################EKS#####################
cluster_name = "eks"
cluster_version = "1.29"
node_instance_types = ["t2.micro"]
desired_capacity = 2
min_capacity = 1
max_capacity = 3
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
cluster_sg_rules_cidr = {
  rule1 = {
    type        = "ingress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },

  rule2 = {
    type        = "egress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
}

cluster_sg_rules_sg = {
  rule1 = {
    type        = "ingress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = null
  },

  rule2 = {
    type        = "egress"
    from_port   = "10250"
    to_port     = "10250"
    protocol    = "tcp"
    cidr_blocks = null
  }
}

node_sg_rules_cidr = {
  rule1 = {
    type        = "egress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  },
  rule2 = {
    type        = "egress"
    from_port   = "10250"
    to_port     = "10250"
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
}

node_sg_rules_sg = {
  rule1 = {
    type        = "ingress"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = null
  },
  rule2 = {
    type        = "ingress"
    from_port   = "10250"
    to_port     = "10250"
    protocol    = "tcp"
    cidr_blocks = null
  },
  rule3 = {
    type        = "ingress"
    from_port   = "8443"
    to_port     = "8443"
    protocol    = "tcp"
    cidr_blocks = null
  },
  rule4 = { #aws lb webhook
    type        = "ingress"
    from_port   = "9443"
    to_port     = "9443"
    protocol    = "tcp"
    cidr_blocks = null
  }
}

cluster_oidc_issuer_url = "https://oidc.eks.region.amazonaws.com/id/eks-cluster-id"
#####################RDS#####################
rds_name              = "rds"
rds_instance_class    = "db.t3.micro"
rds_allocated_storage = "20"
rds_engine            = "mysql"
engine_version        = "8.0.33"
rds_username          = "test"
rds_password          = "test123!!"
rds_db_name           = "collect"
rds_subnet_a_cidr     = "10.0.110.0/24"
rds_subnet_b_cidr     = "10.0.120.0/24"
rds_az_a              = "ap-northeast-2a"
rds_az_b              = "ap-northeast-2b"


rds_sg_rules_cidr = {
  rule1 = {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "10.0.10.0/24"
  },
  rule2 = {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  },
  rule3 = {
    type        = "ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "10.0.20.0/24"
  }
}

#################ECS################
ecs_cluster_name = "example-ecs-cluster"

ecs_task_cpu    = "256"
ecs_task_memory = "512"
ecs_desired_count = 1

ecs_ingress_ports = [
  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

ecs_egress_ports = [
  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

#################Aurora################
aurora_cluster_identifier = "my-aurora-cluster"
aurora_engine_version     = "5.7.mysql_aurora.2.11.1"
aurora_master_username    = "admin"
aurora_master_password    = "test12345"
aurora_database_name      = "mydatabase"
aurora_backup_retention_period = 7
aurora_preferred_backup_window = "07:00-09:00"
aurora_db_subnet_group_name = "aurora-subnet-group"
aurora_instance_count     = 2
aurora_instance_class     = "db.r5.large"
aurora_ingress_port       = 3306
aurora_ingress_cidr_blocks = ["0.0.0.0/0"]

aurora_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

#################Iam################
admin_group_name = "admin"
admin_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
user_names       = ["user1", "user2", "user3", "user4"]

