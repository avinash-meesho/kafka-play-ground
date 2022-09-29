
output "zookeeper" {
  value = flatten([
    for node in google_compute_instance.zookeeper :
    node.network_interface.*.network_ip
  ])
}

output "kafka_broker" {
  value = flatten([
    for node in google_compute_instance.broker :
    node.network_interface.*.network_ip
  ])
}

output "control_center" {
  value = flatten([
    for node in google_compute_instance.c3 :
    node.network_interface.*.network_ip
  ])
}

output "kafka_connect" {
  value = flatten([
    for node in google_compute_instance.connect :
    node.network_interface.*.network_ip
  ])

}

output "ksql" {
  value = flatten([
    for node in google_compute_instance.ksql :
    node.network_interface.*.network_ip
  ])

}

output "schema_registry" {
  value = flatten([
    for node in google_compute_instance.schema_registry :
    node.network_interface.*.network_ip
  ])

}

output "kafka_rest" {
  value = flatten([
    for node in google_compute_instance.rest_proxy :
    node.network_interface.*.network_ip
  ])

}
