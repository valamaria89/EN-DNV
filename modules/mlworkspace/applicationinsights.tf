resource "azurerm_application_insights" "ai" {
  name                = "${var.organization}-${var.product}-${var.stage}-ai-${local.shortname_locations[var.location]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  tags = merge(var.tags, {})

}
