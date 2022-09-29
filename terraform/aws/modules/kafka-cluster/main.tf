
module "zookeeper" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "zookeeper"

  ami            = var.zookeeper_ami != "" ? var.zookeeper_ami : var.default_ami
  instance_type  = var.zookeeper_type != "" ? var.zookeeper_type : var.default_instance_type
  instance_count = var.zookeeper_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    zk1 : {
      description : "",
      port : 2181
    },
    zk2 : {
      description : "",
      port : 2888
    },
    zk3 : {
      description : "",
      port : 3888
    }
  }
}

module "broker" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "broker"

  ami            = var.broker_ami != "" ? var.broker_ami : var.default_ami
  instance_type  = var.broker_type != "" ? var.broker_type : var.default_instance_type
  instance_count = var.broker_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    bk1 : {
      description : "",
      port : 9091
    },
    bk2 : {
      description : "",
      port : 9092
    },
    bk3 : {
      description : "",
      port : 8090
    }
  }
}

module "c3" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "c3"

  ami            = var.c3_ami != "" ? var.c3_ami : var.default_ami
  instance_type  = var.c3_type != "" ? var.c3_type : var.default_instance_type
  instance_count = var.c3_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    c3 : {
      description : "",
      port : 9021
    }
  }
}

module "connect" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "connect"

  ami            = var.connect_ami != "" ? var.connect_ami : var.default_ami
  instance_type  = var.connect_type != "" ? var.connect_type : var.default_instance_type
  instance_count = var.connect_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    connect : {
      description : "",
      port : 8083
    }
  }
}


module "ksql" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "ksql"

  ami            = var.ksql_ami != "" ? var.ksql_ami : var.default_ami
  instance_type  = var.ksql_type != "" ? var.ksql_type : var.default_instance_type
  instance_count = var.ksql_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    ksql : {
      description : "",
      port : 8088
    }
  }
}

module "schema-registry" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "schema-registry"

  ami            = var.schema_registry_ami != "" ? var.schema_registry_ami : var.default_ami
  instance_type  = var.schema_registry_type != "" ? var.schema_registry_type : var.default_instance_type
  instance_count = var.schema_registry_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    schema-registry : {
      description : "",
      port : 8081
    }
  }
}

module "rest-proxy" {
  source = "../sg_instance"

  resource_prefix = var.resource_prefix
  instance_name   = "rest-proxy"

  ami            = var.rest_proxy_ami != "" ? var.rest_proxy_ami : var.default_ami
  instance_type  = var.rest_proxy_type != "" ? var.rest_proxy_type : var.default_instance_type
  instance_count = var.rest_proxy_count

  ssh_key_name   = var.ssh_key_name

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  ingress_ports = {
    ssh : {
      description : "",
      port : 22
    },
    rest-proxy : {
      description : "",
      port : 8082
    }
  }
}
