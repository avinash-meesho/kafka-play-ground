terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = file("~/local/creds/kafka-project-sa.json")
  region      = var.gcp_region
  project     = var.gcp_project
}

provider "google-beta" {
  credentials = file("~/local/creds/kafka-project-sa.json")
  region      = var.gcp_region
  project     = var.gcp_project
}

locals {
  ssh_key     = "ubuntu:${file("~/.ssh/shin-gcp-key.pub")}"
  subnet_name = "${var.resource_prefix}-subnet"
}

data "google_compute_zones" "available_zones" {}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.0"

  project_id   = var.gcp_project
  network_name = "${var.resource_prefix}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name      = local.subnet_name
      subnet_ip        = "10.10.10.0/24"
      subnet_region    = var.gcp_region
      subnet_flow_logs = "true"

    }
  ]
}

resource "google_compute_router" "router" {
  name    = "${var.resource_prefix}-router"
  region  = var.gcp_region
  network = module.vpc.network_id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.resource_prefix}-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_address" "bastion_static" {
  name = "${var.resource_prefix}-bastion"
}

resource "google_compute_instance" "bastion" {
  name         = "${var.resource_prefix}-bastion"
  zone         = data.google_compute_zones.available_zones.names[0]
  machine_type = var.default_instance_type

  boot_disk {
    initialize_params {
      image = var.default_instance_image
    }
  }

  network_interface {
    subnetwork = local.subnet_name

    access_config {
      nat_ip = google_compute_address.bastion_static.address
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/shin-gcp-key.pub")}"
  }

  depends_on = [
    module.vpc
  ]
}

resource "google_compute_firewall" "bastion_fw" {
  name    = "${var.resource_prefix}-bastion-rule"
  network = module.vpc.network_name

  allow {
    ports    = ["22", "80", "443", "9021", "9092"]
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
}

resource "google_compute_firewall" "kafka_fw" {
  name    = "${var.resource_prefix}-kafka-rule"
  network = module.vpc.network_name

  allow {
    ports    = ["22", "2181", "2888", "3888", "8081", "8082", "8083", "8088", "8090", "9021", "9091", "9092"]
    protocol = "tcp"
  }

  source_ranges = ["10.10.0.0/16"]
  priority      = 1001
}

module "kafka-cluster" {
  source = "./modules/kafka-cluster"

  availability_zones    = data.google_compute_zones.available_zones.names
  subnet                = local.subnet_name
  resource_prefix       = var.resource_prefix
  ssh_key               = local.ssh_key
  default_image         = var.default_instance_image
  default_instance_type = var.default_instance_type

  zookeeper_count       = var.zookeeper_count
  broker_count          = var.broker_count
  c3_count              = var.c3_count
  schema_registry_count = var.schema_registry_count
  connect_count         = var.connect_count
  ksql_count            = var.ksql_count
  rest_proxy_count      = var.rest_proxy_count

  zookeeper_type = var.zookeeper_instance_type
  schema_registry_type = var.zookeeper_instance_type
  c3_type        = var.broker_instance_type
  ksql_type      = var.broker_instance_type
  broker_type    = var.broker_instance_type
  connect_type   = var.broker_instance_type

  depends_on = [
    module.vpc
  ]
}