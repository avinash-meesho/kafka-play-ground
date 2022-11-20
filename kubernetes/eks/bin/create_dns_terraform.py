import os
import json

namespace = 'confluent'
base_domain = 'eks.shin.ps.confluent.io'

cmd = 'kubectl get services -o json -n ' + namespace
extract_lb = '.items[] | select(.spec.type == "LoadBalancer") | {(.metadata.name): .status.loadBalancer.ingress[0].hostname}'
cmd += " | jq -c '" + extract_lb + "' | jq -s add"

output = os.popen(cmd).read()
loadbalancers = json.loads(output)

# reference
# https://docs.confluent.io/operator/current/co-loadbalancers.html#configure-load-balancers-to-access-confluent-components
dns_mapping = {
  "connect-bootstrap-lb": "connect",
  "controlcenter-bootstrap-lb": "c3",
  "kafka-0-lb": "b0",
  "kafka-1-lb": "b1",
  "kafka-2-lb": "b2",
  "kafka-bootstrap-lb": "kafka",
  "kafkarestproxy-bootstrap-lb": "kafkarestproxy",
  "ksqldb-bootstrap-lb": "ksql",
  "schemaregistry-bootstrap-lb": "schemaregistry"
}


def terraform_route53_record(key, dns, value):
  return """
resource "aws_route53_record" "%s" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "%s"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["%s"]
}""" % (key, dns, value)

def terraform_route53_output(key):
  return """
output "%s" {
  value = aws_route53_record.%s.name
}""" % (key, key)

terraform = """provider "aws" {
  region  = var.region
  profile = var.aws_profile
}"""

tf_output = ""

for key in dns_mapping:
  dns = dns_mapping[key] + '.' + base_domain
  value = loadbalancers[key]
  if dns and value: 
    terraform += '\n' + terraform_route53_record(key, dns, value)
    tf_output += terraform_route53_output(key)

with open('dns-terraform/main.tf', 'w') as tf_main_file:
    tf_main_file.write(terraform)
with open('dns-terraform/output.tf', 'w') as tf_output_file:
    tf_output_file.write(tf_output)
