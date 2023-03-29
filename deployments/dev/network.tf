locals {
  compute_instance_subnet_prefix           = cidrsubnet(var.address_space, 10, 0)
  compute_cluster_subnet_prefix            = cidrsubnet(var.address_space, 11, 2)
  compute_cluster_private_endpoints_prefix = cidrsubnet(var.address_space, 11, 3)
}


resource "azurerm_virtual_network" "ml" {
  name                = "${var.organization}-${var.product}-${var.stage}-vnet-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.mlworkspace.name

  address_space = [var.address_space]
  dns_servers   = var.dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "compute_instance" {
  name                 = "${var.organization}-${var.product}-${var.stage}-snet-instance-${local.shortname_locations[var.location]}"
  resource_group_name  = azurerm_resource_group.mlworkspace.name
  virtual_network_name = azurerm_virtual_network.ml.name

  address_prefixes = [local.compute_instance_subnet_prefix]
}


resource "azurerm_subnet" "compute_cluster" {
  name                 = "${var.organization}-${var.product}-${var.stage}-snet-cluster-${local.shortname_locations[var.location]}"
  resource_group_name  = azurerm_resource_group.mlworkspace.name
  virtual_network_name = azurerm_virtual_network.ml.name

  address_prefixes = [local.compute_cluster_subnet_prefix]
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = "${var.organization}-${var.product}-${var.stage}-snet-endpoints-${local.shortname_locations[var.location]}"
  resource_group_name  = azurerm_resource_group.mlworkspace.name
  virtual_network_name = azurerm_virtual_network.ml.name

  address_prefixes = [local.compute_cluster_private_endpoints_prefix]
}

resource "azurerm_virtual_network_peering" "spoke" {
  for_each = { for index, vnet in var.peered_networks : vnet.name => vnet }

  name                      = "${var.organization}-${var.product}-${var.stage}-peer-to-${each.value.name}-${local.shortname_locations[var.location]}"
  resource_group_name       = azurerm_resource_group.mlworkspace.name
  virtual_network_name      = azurerm_virtual_network.ml.name
  remote_virtual_network_id = each.value.network_id
}