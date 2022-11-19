
output "connect-bootstrap-lb" {
  value = aws_route53_record.connect-bootstrap-lb.name
}
output "controlcenter-bootstrap-lb" {
  value = aws_route53_record.controlcenter-bootstrap-lb.name
}
output "kafka-0-lb" {
  value = aws_route53_record.kafka-0-lb.name
}
output "kafka-1-lb" {
  value = aws_route53_record.kafka-1-lb.name
}
output "kafka-2-lb" {
  value = aws_route53_record.kafka-2-lb.name
}
output "kafka-bootstrap-lb" {
  value = aws_route53_record.kafka-bootstrap-lb.name
}
output "kafkarestproxy-bootstrap-lb" {
  value = aws_route53_record.kafkarestproxy-bootstrap-lb.name
}
output "ksqldb-bootstrap-lb" {
  value = aws_route53_record.ksqldb-bootstrap-lb.name
}
output "schemaregistry-bootstrap-lb" {
  value = aws_route53_record.schemaregistry-bootstrap-lb.name
}