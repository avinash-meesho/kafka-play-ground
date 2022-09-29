
resource "google_compute_instance" "zookeeper" {
  count = var.zookeeper_count
  name  = "${var.resource_prefix}-zookeeper"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.zookeeper_type != "" ? var.zookeeper_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.zookeeper_image != "" ? var.zookeeper_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}

resource "google_compute_instance" "broker" {
  count = var.broker_count
  name  = "${var.resource_prefix}-broker"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.broker_type != "" ? var.broker_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.broker_image != "" ? var.broker_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}

resource "google_compute_instance" "c3" {
  count = var.c3_count
  name  = "${var.resource_prefix}-c3"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.c3_type != "" ? var.c3_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.c3_image != "" ? var.c3_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}

resource "google_compute_instance" "connect" {
  count = var.connect_count
  name  = "${var.resource_prefix}-connect"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.connect_type != "" ? var.connect_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.connect_image != "" ? var.connect_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}

resource "google_compute_instance" "ksql" {
  count = var.ksql_count
  name  = "${var.resource_prefix}-ksql"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.ksql_type != "" ? var.ksql_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.ksql_image != "" ? var.ksql_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}

resource "google_compute_instance" "schema_registry" {
  count = var.schema_registry_count
  name  = "${var.resource_prefix}-schema-registry"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.schema_registry_type != "" ? var.schema_registry_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.schema_registry_image != "" ? var.schema_registry_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}

resource "google_compute_instance" "rest_proxy" {
  count = var.rest_proxy_count
  name  = "${var.resource_prefix}-rest-proxy"
  zone = var.availability_zones[
    count.index % length(var.availability_zones)
  ]
  machine_type = var.rest_proxy_type != "" ? var.rest_proxy_type : var.default_instance_type
  boot_disk {
    initialize_params {
      image = var.rest_proxy_image != "" ? var.rest_proxy_image : var.default_image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }
  metadata = {
    ssh-keys = var.ssh_key
  }
}