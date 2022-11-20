provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

resource "aws_route53_record" "connect-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "connect.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["abccb8254831e4906b2ad01fabcca4e9-81168925.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "controlcenter-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "c3.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["af802ea1cadea41218c9b86a6eeddf89-1829935743.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-0-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b0.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a1c2d4508b5e743b6ba61cd2ff50e98b-207272677.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-1-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b1.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a2fdd9c17df7b4f01900121549a7eb0b-1375572769.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-2-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b2.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a77a944e3d2a549af88b7076ca30e03d-1807297606.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "kafka.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["ab8541acc781e45eca445ce647fd1a6e-65939159.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafkarestproxy-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "kafkarestproxy.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["ac0ce4ad2dc6e4701bd196a6d4f62f1f-184731517.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "ksqldb-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "ksql.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a2da822e4e02841f39a2bd43da0b397f-542587883.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "schemaregistry-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "schemaregistry.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["ae088903f9acf4cbd84ec35a711dda1d-968410460.ap-southeast-2.elb.amazonaws.com"]
}