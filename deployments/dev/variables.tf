variable "tenant_id" {
  type        = string
  description = "The tenant id"
}

variable "organization" {
  type        = string
  description = "The organization name"
}

variable "product" {
  type        = string
  description = "The product name"
}

variable "stage" {
  type        = string
  description = "The lifecycle name"
}

variable "location" {
  type        = string
  description = "The location name"
}

variable "tags" {
  type        = map(string)
  description = "values for tags"
}

variable "address_space" {
  type        = string
  description = "Address space for the virtual network"
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS servers for the virtual network"
}


variable "peered_networks" {
  type = list(object({
    name       = string
    network_id = string
  }))
  description = "values for peered spoke networks"
}