variable "availability_zones" {
  type = list(string)
}

variable "subnet" {
  type = string
}

variable "resource_prefix" {
  type = string
}

variable "ssh_key" {
  type = string
}

# ============= cluster instance configurations =============

variable "default_image" {
  type        = string
  description = "default ami for kafka cluster, it can be overwritten by component ami"
}

variable "default_instance_type" {
  type        = string
  description = "default instance type for kafka cluster, it can be overwritten by component type"
}

variable "zookeeper_image" {
  type    = string
  default = ""
}

variable "zookeeper_type" {
  type    = string
  default = ""
}

variable "zookeeper_count" {
  type = number
}

variable "broker_image" {
  type    = string
  default = ""
}

variable "broker_type" {
  type    = string
  default = ""
}

variable "broker_count" {
  type = number
}

variable "c3_image" {
  type    = string
  default = ""
}

variable "c3_type" {
  type    = string
  default = ""
}

variable "c3_count" {
  type = number
}

variable "connect_image" {
  type    = string
  default = ""
}

variable "connect_type" {
  type    = string
  default = ""
}

variable "connect_count" {
  type = number
}

variable "ksql_image" {
  type    = string
  default = ""
}

variable "ksql_type" {
  type    = string
  default = ""
}

variable "ksql_count" {
  type = number
}

variable "schema_registry_image" {
  type    = string
  default = ""
}

variable "schema_registry_type" {
  type    = string
  default = ""
}

variable "schema_registry_count" {
  type = number
}

variable "rest_proxy_image" {
  type    = string
  default = ""
}

variable "rest_proxy_type" {
  type    = string
  default = ""
}

variable "rest_proxy_count" {
  type = number
}
