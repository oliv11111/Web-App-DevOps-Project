

# AKS Cluster Configuration
variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "cluster_location" {
  type        = string
  description = "Azure region where the AKS cluster will be deployed"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix of the cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the AKS cluster"
}

variable "service_principal_client_id" {
  type        = string
  description = "Client ID for the service principal associated with the cluster"
}

variable "service_principal_secret" {
  type        = string
  description = "Client Secret for the service principal associated with the cluster"
}

# Networking Module Outputs as Input Variables
variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group for networking resources"
}

variable "vnet_id" {
  type        = string
  description = "ID of the Virtual Network (VNet)"
}

variable "control_plane_subnet_id" {
  type        = string
  description = "ID of the control plane subnet"
}

variable "worker_node_subnet_id" {
  type        = string
  description = "ID of the worker node subnet"
}












