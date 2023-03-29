locals {
  shortname_locations = {
    "westeurope" = "we"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mlworkspace" {
  name     = "${var.organization}-${var.product}-${var.stage}-rg-${local.shortname_locations[var.location]}"
  location = var.location
  tags     = var.tags
}

module "mlworkspace" {
  source = "../../modules/mlworkspace"

  virtual_network_name          = azurerm_virtual_network.ml.name
  compute_instance_subnet_name  = azurerm_subnet.compute_instance.name
  compute_cluster_subnet_name   = azurerm_subnet.compute_cluster.name
  private_endpoints_subnet_name = azurerm_subnet.private_endpoints.name

  resource_group_name = azurerm_resource_group.mlworkspace.name
  tenant_id           = var.tenant_id
  organization        = var.organization
  product             = var.product
  stage               = var.stage
  location            = var.location
  tags                = var.tags

  depends_on = [
    azurerm_subnet.compute_cluster,
    azurerm_subnet.compute_instance,
    azurerm_subnet.private_endpoints
  ]

}
