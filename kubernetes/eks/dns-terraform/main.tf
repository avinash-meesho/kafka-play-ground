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
  records         =  ["a3da8fdd8b1bb4b78800f9a2307b92c3-1592827776.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "controlcenter-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "c3.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["aa1bd7c2b3ec14f0798c79279c272b0b-561692509.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-0-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b0.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["ad87ad57609314c47abb4ffe29fcfe25-2011985066.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-1-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b1.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a82f1b1ee309648fa9f5dd3248e591d0-1561373516.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-2-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b2.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a9a1bbe25478e48e58577b8a98fa9ea5-399626083.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "kafka.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a5aa950e4b8fa4a96a546b0f286dbde4-570617852.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafkarestproxy-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "kafkarestproxy.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a267d06af4df0461a8756d31f0033e9e-978512888.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "ksqldb-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "ksql.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["a84848d17e57e426388ca677a103937c-1475624100.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "schemaregistry-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "schemaregistry.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "300"
  records         =  ["ad84cf3f7abc749498c420d1c6e92194-1816775946.ap-southeast-2.elb.amazonaws.com"]
}