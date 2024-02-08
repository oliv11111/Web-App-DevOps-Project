# Milestone 4: DevOps Project - README

## Introduction
In this milestone, I initalised the cluster module for the terraform project. This code is what established the structure of the aks cluster used in the project. The steps and benefits were similar to the previous milestone where I initalised the networking modules, with a few tweaks and changes to the reasources, groups and variables.


### How It Works 
#### Step 1: Create variables file 
This step was to create the variable.tf file. The variables.tf file in a Terraform project is used to define input variables. These variables act as parameters that allow users to customize the behavior of Terraform configurations without modifying the underlying code. By defining variables, you can create flexible and reusable Terraform modules that adapt to different environments, configurations, or user preferences.

The varibales defined were:
1. **aks_cluster_name**:
   - *Type*: string
   - *Description*: Name of the AKS cluster.

2. **cluster_location**:
   - *Type*: string
   - *Description*: Azure region where the AKS cluster will be deployed.

3. **dns_prefix**:
   - *Type*: string
   - *Description*: DNS prefix of the cluster.

4. **kubernetes_version**:
   - *Type*: string
   - *Description*: Kubernetes version for the AKS cluster.

5. **service_principal_client_id**:
   - *Type*: string
   - *Description*: Client ID for the service principal associated with the cluster.

6. **service_principal_secret**:
   - *Type*: string
   - *Description*: Client Secret for the service principal associated with the cluster.

Note: These are varibles from the network module
7. **resource_group_name**:
   - *Type*: string
   - *Description*: Name of the Azure Resource Group for networking resources.

8. **vnet_id**:
   - *Type*: string
   - *Description*: ID of the Virtual Network (VNet).

9. **control_plane_subnet_id**:
   - *Type*: string
   - *Description*: ID of the control plane subnet.

10. **worker_node_subnet_id**:
    - *Type*: string
    - *Description*: ID of the worker node subnet.

#### Step 3: Create main.tf file
This main.tf file is crucial for provisioning an Azure Kubernetes Service (AKS) cluster using Terraform. It defines essential attributes such as the cluster name, location, and Kubernetes version. Additionally, it specifies the default node pool configuration and provides the necessary credentials for the service principal associated with the cluster. Ultimately, this file enables automated and reproducible deployment of AKS clusters, streamlining the management of Kubernetes infrastructure within Azure environments.
1. **AKS Cluster Resource**:
   - Defines an Azure Kubernetes Service (AKS) cluster using the `azurerm_kubernetes_cluster` resource.
   - Specifies the cluster's name, location, resource group, DNS prefix, and Kubernetes version.

2. **Default Node Pool**:
   - Configures the default node pool with a single node, using a specific VM size, and enables auto-scaling with a minimum of 1 node and a maximum of 3 nodes.

3. **Service Principal**:
   - Provides the service principal credentials (client ID and client secret) for authentication to Azure services within the cluster.

#### Step 4: 
The outputs.tf file defines the output variables for the Terraform module, providing access to key information such as the AKS cluster name, ID, and kubeconfig for external use.
The outputs are as follows:
1. **AKS Cluster Name**:
   - Retrieves the name of the provisioned AKS cluster using the `azurerm_kubernetes_cluster` resource.

2. **AKS Cluster ID**:
   - Retrieves the ID of the provisioned AKS cluster using the `azurerm_kubernetes_cluster` resource.

3. **AKS Kubeconfig**:
   - Retrieves the Kubernetes configuration file (kubeconfig) for accessing the AKS cluster.

#### Step 5: 
Now the essential files, variables, resources and outputs were created and defined it was time to initlaise the terraform project. To do this the following command is used.
```bash
terraform init
```
If done correctly a success message is displayed reading
```bash
oliv11111@LAPTOP-HM3O2P8O:~/aicore/Web-App-DevOps-Project/aks-terraform/aks-cluster-module$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/azurerm...
- Installing hashicorp/azurerm v3.89.0...
- Installed hashicorp/azurerm v3.89.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.
```
#### Step 6: 
A quick step to check that the infastructure had been set up correctly is to run the terraform validate command.
```bash
oliv11111@LAPTOP-HM3O2P8O:~/aicore/Web-App-DevOps-Project/aks-terraform/aks-cluster-module$ terraform validate
Success! The configuration is valid.

╵
```

## For the Developer
### Benefits
1. Enables easy retrieval of AKS cluster details for further automation or scripting purposes.
 
2. Enhances collaboration and communication by providing standardized outputs that can be shared among team members or integrated into deployment pipelines.
  

## Branch Information:

- The feature was implemented in a branch named `terraform-cluster`.

## For End-Users

### Benefits

1. Access to crucial information about the AKS cluster, such as its name, ID, and kubeconfig, facilitating integration with other services or tools.

2. Simplified access to relevant cluster details without the need to navigate through the Azure portal or command-line interfaces.


