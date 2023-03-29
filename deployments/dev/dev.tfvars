tenant_id = "8f47ad71-44ca-48bf-afe3-56b9360a4495"
organization = "en"
product = "mlops"
stage = "dev"
location = "westeurope"
tags = {
    client = "DNVENERGY"
}
peered_networks = [{
  name       = "hub"
  network_id = "/subscriptions/9017d57d-c4df-480d-b92d-7aea2266b0f0/resourceGroups/en-mlhubnetwork-dev-rg-we/providers/Microsoft.Network/virtualNetworks/en-mlhub-dev-vnet-we"
}]
address_space = "10.43.0.0/16"
dns_servers   = ["10.42.1.4", "10.42.1.5"]



