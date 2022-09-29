
variable "gcp_region" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "resource_prefix" {
  type = string
}

variable "default_instance_image" {
  type = string
}

variable "default_instance_type" {
  type = string
}

variable "zookeeper_instance_type" {
  type    = string
  default = ""
}

variable "broker_instance_type" {
  type    = string
  default = ""
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

