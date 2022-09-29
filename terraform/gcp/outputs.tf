output "bastion" {
  value = google_compute_address.bastion_static.address
}

output "kafka_cluster" {
  value = module.kafka-cluster
}