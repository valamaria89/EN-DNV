resource "azurerm_machine_learning_workspace" "workspace" {
  name                    = "${var.organization}-${var.product}-${var.stage}-mlw-${local.shortname_locations[var.location]}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.ai.id
  key_vault_id            = azurerm_key_vault.ml-kv.id
  storage_account_id      = azurerm_storage_account.ml-workspace-st.id
  container_registry_id   = azurerm_container_registry.ml-acr.id

  identity {
    type = "SystemAssigned"
  }

  # Required for vnet
  public_network_access_enabled = "false"
  depends_on = [
    azurerm_private_endpoint.pvt-endpoint-ml-acr,
    azurerm_private_endpoint.pvt-endpoint-ml-blob,
    azurerm_private_endpoint.pvt-endpoint-ml-file,
    azurerm_private_endpoint.pvt-endpoint-ml-queue,
    azurerm_private_endpoint.pvt-endpoint-ml-table,
  ]

  tags = merge(var.tags, {})

}

resource "azurerm_private_endpoint" "pvt-endpoint-ml-workspace" {
  name                = "${var.organization}-${var.product}-${var.stage}-mlw-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "${var.organization}-${var.product}-${var.stage}-mlw-${local.shortname_locations[var.location]}"
    private_connection_resource_id = azurerm_machine_learning_workspace.workspace.id
    is_manual_connection           = false
    subresource_names              = ["amlworkspace"]
  }

  tags = merge(var.tags)
}

resource "azurerm_machine_learning_compute_cluster" "image-builder" {
  name                          = local.image_builder_name
  location                      = var.location
  vm_priority                   = "Dedicated"
  vm_size                       = "STANDARD_DS2_V2"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.workspace.id
  subnet_resource_id            = data.azurerm_subnet.compute_cluster.id
  ssh_public_access_enabled     = "false"
  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 1
    scale_down_nodes_after_idle_duration = "PT15M" # 15 minutes
  }

  tags = merge(var.tags, {})

  identity {
    type = "SystemAssigned"
  }
}