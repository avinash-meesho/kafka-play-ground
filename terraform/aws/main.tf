
provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = {
      owner       = var.owner_name
      owner_email = var.owner_email
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.resource_prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-2c"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true
}

module "bastion" {
  source = "./modules/sg_instance"

  resource_prefix = var.resource_prefix
  ssh_key_name    = var.ssh_key_name
  instance_name   = "bastion"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnets[0]]
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    http : {
      description : "http",
      port : 80
    },
    https : {
      description : "https",
      port : 443
    },
    ccbroker: {
      description : "ccbroker",
      port: 9092
    },
    c3 : {
      description : "c3",
      port : 9021
    }
  }

  ami           = var.bastion.ami
  instance_type = var.bastion.type

  instance_count = 1
}

module "kafka-cluster" {
  source = "./modules/kafka-cluster"

  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  resource_prefix = var.resource_prefix
  ssh_key_name    = var.ssh_key_name

  default_ami           = var.kafka_default_ami
  default_instance_type = var.kafka_default_instance_type

  zookeeper_count       = var.zookeeper_count
  broker_count          = var.broker_count
  c3_count              = var.c3_count
  schema_registry_count = var.schema_registry_count
  connect_count         = var.connect_count
  ksql_count            = var.ksql_count
  rest_proxy_count      = var.rest_proxy_count

  c3_type      = "t3a.large"
  ksql_type    = "t3a.large"
  broker_type  = "t3a.large"
  connect_type = "t3a.large"
}