
output "aks_cluster_name" {
    value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
    value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_kubeconfig" {
    value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}