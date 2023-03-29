
resource "azurerm_storage_account" "ml-workspace-st" {
  name                = "${var.organization}${var.product}${var.stage}st${local.shortname_locations[var.location]}"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  enable_https_traffic_only       = "true"
  allow_nested_items_to_be_public = "false"
  public_network_access_enabled   = "true" # Only from selected network
  shared_access_key_enabled       = "true"
  min_tls_version                 = "TLS1_2"


  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]

  }
  identity {
    type = "SystemAssigned"
  }

  blob_properties {
    delete_retention_policy {
      days = 90
    }

    container_delete_retention_policy {
      days = 90
    }
  }

  tags = merge(var.tags, {})
  lifecycle {
    ignore_changes = [
      blob_properties

    ]
  }

}


resource "azurerm_private_endpoint" "pvt-endpoint-ml-blob" {
  name                = "${var.organization}-${var.product}-${var.stage}-st-blob-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "${var.organization}-${var.product}-${var.stage}-st-blob-${local.shortname_locations[var.location]}"
    private_connection_resource_id = azurerm_storage_account.ml-workspace-st.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = merge(var.tags)
}

resource "azurerm_private_endpoint" "pvt-endpoint-ml-file" {
  name                = "${var.organization}-${var.product}-${var.stage}-st-file-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "${var.organization}-${var.product}-${var.stage}-st-file-${local.shortname_locations[var.location]}"
    private_connection_resource_id = azurerm_storage_account.ml-workspace-st.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  tags = merge(var.tags)
}

resource "azurerm_private_endpoint" "pvt-endpoint-ml-queue" {
  name                = "${var.organization}-${var.product}-${var.stage}-st-queue-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "${var.organization}-${var.product}-${var.stage}-st-queue-${local.shortname_locations[var.location]}"
    private_connection_resource_id = azurerm_storage_account.ml-workspace-st.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = merge(var.tags)
}


resource "azurerm_private_endpoint" "pvt-endpoint-ml-table" {
  name                = "${var.organization}-${var.product}-${var.stage}-st-table-pep-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "${var.organization}-${var.product}-${var.stage}-st-table-${local.shortname_locations[var.location]}"
    private_connection_resource_id = azurerm_storage_account.ml-workspace-st.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  tags = merge(var.tags)
}
