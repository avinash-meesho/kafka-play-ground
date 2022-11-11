variable "aws_profile" {
  type = string
}

variable "region" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "owner_email" {
  type = string
}

variable "resource_prefix" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "dns_suffix" {
  type = string
}

variable "bastion" {
  type = object({
    ami  = string
    type = string
  })
  default = {
    ami  = "ami-055166f8a8041fbf1" # ubuntu 20.04
    type = "t2.micro"
  }
}

variable "kafka_default_ami" {
  type = string
}

variable "kafka_default_instance_type" {
  type = string
}

variable "zookeeper_count" {
  type = number
}

variable "broker_count" {
  type = number
}

variable "c3_count" {
  type = number
}

variable "schema_registry_count" {
  type = number
}

variable "connect_count" {
  type = number
}

variable "ksql_count" {
  type = number
}

variable "rest_proxy_count" {
  type = number
}
