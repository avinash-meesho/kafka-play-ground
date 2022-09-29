output "zookeeper" {
  value = flatten(module.zookeeper.*.private_dns)
}

output "kafka_broker" {
  value = flatten(module.broker.*.private_dns)
}

output "control_center" {
  value = flatten(module.c3.*.private_dns)
}

output "kafka_connect" {
  value =flatten(module.connect.*.private_dns)
}

output "ksql" {
  value = flatten(module.ksql.*.private_dns)
}

output "schema_registry" {
  value = flatten(module.schema-registry.*.private_dns)
}

output "kafka_rest" {
  value = flatten(module.rest-proxy.*.private_dns)
}
