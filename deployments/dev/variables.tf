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
  validation {
    condition     = contains(["dev", "prod", "test"], var.stage)
    error_message = "Stage must be one of the three dev, prod, test."
  }
}

variable "location" {
  type        = string
  description = "The location name"
  validation {
    condition     = contains(["westeurope"], var.location)
    error_message = "Location must be westeurope."
  }
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