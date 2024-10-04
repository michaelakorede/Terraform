provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub-spoke"
  location = var.location
}

# Hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Hub Subnet for Azure Firewall
resource "azurerm_subnet" "hub_subnet" {
  name                 = "hub-firewall-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Spoke 1 Virtual Network (HR)
resource "azurerm_virtual_network" "spoke1_vnet" {
  name                = "spoke1-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Spoke 1 Subnet
resource "azurerm_subnet" "spoke1_subnet" {
  name                 = "spoke1-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke1_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Spoke 2 Virtual Network (Finance)
resource "azurerm_virtual_network" "spoke2_vnet" {
  name                = "spoke2-vnet"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Spoke 2 Subnet
resource "azurerm_subnet" "spoke2_subnet" {
  name                 = "spoke2-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke2_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
}

# Spoke 3 Virtual Network (Engineering)
resource "azurerm_virtual_network" "spoke3_vnet" {
  name                = "spoke3-vnet"
  address_space       = ["10.3.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Spoke 3 Subnet
resource "azurerm_subnet" "spoke3_subnet" {
  name                 = "spoke3-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke3_vnet.name
  address_prefixes     = ["10.3.1.0/24"]
}

# VNet Peering Hub to Spoke1
resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                      = "hub-to-spoke1"
  resource_group_name        = azurerm_resource_group.rg.name
  virtual_network_name       = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id  = azurerm_virtual_network.spoke1_vnet.id
  allow_forwarded_traffic    = true
  allow_gateway_transit      = true
}

# VNet Peering Hub to Spoke2
resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                      = "hub-to-spoke2"
  resource_group_name        = azurerm_resource_group.rg.name
  virtual_network_name       = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id  = azurerm_virtual_network.spoke2_vnet.id
  allow_forwarded_traffic    = true
  allow_gateway_transit      = true
}

# VNet Peering Hub to Spoke3
resource "azurerm_virtual_network_peering" "hub_to_spoke3" {
  name                      = "hub-to-spoke3"
  resource_group_name        = azurerm_resource_group.rg.name
  virtual_network_name       = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id  = azurerm_virtual_network.spoke3_vnet.id
  allow_forwarded_traffic    = true
  allow_gateway_transit      = true
}
