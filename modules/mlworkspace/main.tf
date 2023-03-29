locals {
  shortname_locations = {
    "westeurope" = "we"
  }
  image_builder_name = "${var.organization}-${var.product}-${var.stage}-ib-${local.shortname_locations[var.location]}-001"
}


data "azurerm_subnet" "compute_instance" {
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  name = var.compute_instance_subnet_name
}

data "azurerm_subnet" "compute_cluster" {
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  name = var.compute_cluster_subnet_name
}

data "azurerm_subnet" "private_endpoints" {
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  name = var.private_endpoints_subnet_name
}
