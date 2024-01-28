resource "azurerm_resource_group" "networking" {
    name        = "resource_group_name"
    location    = "UK South"
  
}


resource "azurerm_virtual_network" "aks-vnet" {
    name                    = "aks-vnet"
    address_space           = ["10.0.0.0/16"]
    location                = azurerm_resource_group.networking.location
    resource_group_name     =  azurerm_resource_group.networking.name
  
}

resource "azurerm_subnet" "control-plane-subnet" {
    name = "control-plane-subnet"
    resource_group_name     = azurerm_resource_group.networking.name
    virtual_network_name    = azurerm_virtual_network.aks-vnet.name
    address_prefixes        = ["10.0.1.0/24"]
  
}

resource "azurerm_subnet" "worker-node-subnet" {
    name = "worker-node-subnet"
    resource_group_name     = azurerm_resource_group.networking.name
    virtual_network_name    = azurerm_virtual_network.aks-vnet.name
    address_prefixes        = ["10.0.1.0/24"]
  
}


resource "azurerm_network_security_group" "aks-nsg" {
  name                = "aks-nsg"
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}


resource "azurerm_network_security_rule" "kube_apiserver" {
  name                        = "kube-apiserver-rule"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "192.168.1.240"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks-nsg.name
}


resource "azurerm_network_security_rule" "ssh-rule" {
  name                        = "ssh-rule"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "192.168.1.240"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks-nsg.name
}

