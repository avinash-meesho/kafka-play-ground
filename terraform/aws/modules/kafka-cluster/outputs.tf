output "zookeeper" {
  value = flatten(module.zookeeper.*.custom_dns)
}

output "kafka_broker" {
  value = flatten(module.broker.*.custom_dns)
}

output "control_center" {
  value = flatten(module.c3.*.custom_dns)
}

output "kafka_connect" {
  value = flatten(module.connect.*.custom_dns)
}

output "ksql" {
  value = flatten(module.ksql.*.custom_dns)
}

output "schema_registry" {
  value = flatten(module.schema-registry.*.custom_dns)
}

output "kafka_rest" {
  value = flatten(module.rest-proxy.*.custom_dns)
}
