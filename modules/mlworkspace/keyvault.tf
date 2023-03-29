resource "azurerm_key_vault" "ml-kv" {
  name                            = "${var.organization}-${var.product}-${var.stage}-kv-${local.shortname_locations[var.location]}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = true
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = "true"
  sku_name                        = "standard"
  enable_rbac_authorization       = "true"
  public_network_access_enabled   = "true"
  enabled_for_deployment          = "true"
  enabled_for_template_deployment = "true"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"

  }

  tags = merge(var.tags, {})
}

resource "azurerm_private_endpoint" "pvt-endpoint-ml-kv" {
  name                = "${var.organization}-${var.product}-${var.stage}-kv-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id


  private_service_connection {
    name                           = azurerm_key_vault.ml-kv.name
    private_connection_resource_id = azurerm_key_vault.ml-kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

}