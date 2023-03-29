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
    error_message = "must be one of dev, prod, test"
  }
}

variable "location" {
  type        = string
  description = "The location name"
  default     = "westeurope"

  validation {
    condition     = contains(["westeurope"], var.location)
    error_message = "must be of westeurope"
  }
}

variable "tags" {
  type        = map(string)
  description = "values for tags"
}
