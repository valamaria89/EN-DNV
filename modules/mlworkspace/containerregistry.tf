resource "azurerm_container_registry" "ml-acr" {
  name                = "${var.organization}${var.product}${var.stage}cr${local.shortname_locations[var.location]}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true

  identity {
    type = "SystemAssigned"

  }

  network_rule_set {
    default_action = "Deny"

  }

  tags = merge(var.tags, {})

}

resource "azurerm_private_endpoint" "pvt-endpoint-ml-acr" {
  name                = "${var.organization}-${var.product}-${var.stage}-cr-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id


  private_service_connection {
    name                           = "${var.organization}-${var.product}-${var.stage}-cr-${local.shortname_locations[var.location]}"
    private_connection_resource_id = azurerm_container_registry.ml-acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }

  tags = merge(var.tags, {})
}