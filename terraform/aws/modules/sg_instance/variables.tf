
variable "resource_prefix" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "public_dns" {
  type    = bool
  default = false
}

variable "hosted_zone_id" {
  type = string
}

variable "dns_suffix" {
  type = string
}

variable "ingress_ports" {
  type = map(object({
    description = string
    port        = number
  }))
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "user_data" {
  type    = string
  default = ""
}