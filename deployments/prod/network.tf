resource "azurerm_virtual_network" "ml" {
  name                = "${var.organization}-${var.product}-${var.stage}-vnet-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.mlworkspace.name

  address_space = ["10.43.0.0/16"]

  tags = var.tags
}

resource "azurerm_subnet" "compute_instance" {
  name = "${var.organization}-${var.product}-${var.stage}-snet-instance-${local.shortname_locations[var.location]}"
  resource_group_name = azurerm_resource_group.mlworkspace.name
  virtual_network_name = azurerm_virtual_network.ml.name

  address_prefixes = ["10.43.0.0/26"]
}


resource "azurerm_subnet" "compute_cluster" {
  name = "${var.organization}-${var.product}-${var.stage}-snet-cluster-${local.shortname_locations[var.location]}"
  resource_group_name = azurerm_resource_group.mlworkspace.name
  virtual_network_name = azurerm_virtual_network.ml.name

  address_prefixes = ["10.43.0.64/27"]
}

resource "azurerm_subnet" "private_endpoints" {
  name = "${var.organization}-${var.product}-${var.stage}-snet-endpoints-${local.shortname_locations[var.location]}"
  resource_group_name = azurerm_resource_group.mlworkspace.name
  virtual_network_name = azurerm_virtual_network.ml.name

  address_prefixes = ["10.43.0.96/27"]
}
