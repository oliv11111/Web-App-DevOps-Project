output "vnet_id" {
  description = "ID of the Virtual Network (VNet)."
  value       = azurerm_virtual_network.aks-vnet.id
}

output "control_plane_subnet_id" {
  description = "ID of the control plane subnet."
  value       = azurerm_subnet.control-plane-subnet.id
}

output "worker_node_subnet_id" {
  description = "ID of the worker node subnet."
  value       = azurerm_subnet.worker-node-subnet.id
}

output "resource_group_name" {
  description = "Name of the Azure Resource Group for networking resources."
  value       = azurerm_resource_group.networking.id
}


output "aks_nsg_id" {
  description = "ID of the Network Security Group (NSG) for AKS."
  value       = azurerm_network_security_group.aks-nsg.id
}