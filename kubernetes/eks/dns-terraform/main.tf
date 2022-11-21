provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

resource "aws_route53_record" "connect-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "connect.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a8d7eef0629534b02857d90718bf741c-586859387.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "controlcenter-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "c3.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a15c45710f42a4c04b6bee836c9ec0ae-1057857746.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-0-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b0.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["ab7d420ceb6944106aeb761067451451-1307818107.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-1-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b1.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a7f90cfe66d694efb9835be4a7f4bc67-576018618.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-2-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "b2.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a8f4a32a8a6164287b02d68fa2053896-1070975928.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafka-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "kafka.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a274f49a7877b4c9295cffc411c0d764-379189713.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "kafkarestproxy-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "kafkarestproxy.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a9123be0b9e6f49cb9644108490cc138-1389015676.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "ksqldb-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "ksql.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["a12fe7e929f2647c18356007c1dcb38a-735688733.ap-southeast-2.elb.amazonaws.com"]
}

resource "aws_route53_record" "schemaregistry-bootstrap-lb" {
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "schemaregistry.eks.shin.ps.confluent.io"
  type            = "CNAME"
  ttl             = "5"
  records         =  ["ab43bec516d5446c1884a8d8db6d1ad7-1048123640.ap-southeast-2.elb.amazonaws.com"]
}