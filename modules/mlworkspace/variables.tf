variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network where resources are deployed"
  default = "value"
}

variable "compute_instance_subnet_name" {
  type        = string
  description = "The name of the subnet where compute instances are deployed"
}
  
variable "compute_cluster_subnet_name" {
  type        = string
  description = "The name of the subnet where compute clusters are deployed"
}

variable "private_endpoints_subnet_name" {
  type        = string
  description = "The name of the subnet where private endpoints are deployed"
}


variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources are created"
}

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
  description = "Location must be westeurope."

  validation {
    condition     = contains(["westeurope"], var.location)
    error_message = "Must be of westeurope."
  }
}

variable "tags" {
  type        = map(string)
  description = "values for tags"
  default = {
    "client" = "DNVENERGY"
  }
}
