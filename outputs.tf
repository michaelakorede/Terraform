output "hub_vnet_id" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "spoke1_vnet_id" {
  value = azurerm_virtual_network.spoke1_vnet.id
}

output "spoke2_vnet_id" {
  value = azurerm_virtual_network.spoke2_vnet.id
}

output "spoke3_vnet_id" {
  value = azurerm_virtual_network.spoke3_vnet.id
}
