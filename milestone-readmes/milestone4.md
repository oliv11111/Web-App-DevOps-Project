# Milestone 4: DevOps Project - README

## Introduction
In this milestone, we've established a structured and scalable foundation for deploying Azure networking services to support an Azure Kubernetes Service (AKS) cluster. By organizing the project into modular components, such as networking-module, we enhance reusability and maintainability. Utilizing input variables allows for flexible configurations, enabling adaptation to diverse networking requirements. Defining essential networking resources, including Azure Resource Groups, Virtual Networks (VNet), and Subnets, lays the groundwork for subsequent AKS cluster provisioning. The incorporation of a Network Security Group (NSG) with specific rules bolsters the security posture, ensuring that only authorized traffic reaches critical components. Output variables provide a means of retrieving important information for connecting other modules or external systems. T


### How It Works 
#### Step 1: Create appropriate directories
These directories will house our terraform application. Our two modules in this project will be the networking and cluster module. The primairy focus for this milestone is initalising the newtorking module
```bash
mkdir aks-terraform
cd ask-terraform
mkdir networking-module
mkdir aks-cluster-module
```

#### Step 2: Create variables file 
This step was to create the variable.tf file. The variables.tf file in a Terraform project is used to define input variables. These variables act as parameters that allow users to customize the behavior of Terraform configurations without modifying the underlying code. By defining variables, you can create flexible and reusable Terraform modules that adapt to different environments, configurations, or user preferences.

The varibales defined were:
1. **resource_group_name**:
   - *Type*: string
   - *Default*: "networking_resource_group"
   - *Description*: Represents the name of the Azure Resource Group where networking resources will be deployed.

2. **location**:
   - *Type*: string
   - *Default*: "UK South"
   - *Description*: Specifies the Azure region where networking resources will be deployed.

3. **vnet_address_space**:
   - *Type*: list(string)
   - *Default*: ["10.0.0.0/16"]
   - *Description*: Specifies the address space for the Virtual Network (VNet) that will be created later in the main configuration file.


#### Step 3: Create main.tf file
The next step was the amin.tf file. Up to this point the main.tf file in our networking project is responsible for defining and provisioning essential networking resources for the cluster.  
The resources are as follows:  
1. **Azure Resource Group (Networking):**
   - **Name:** `resource_group_name`
  - **Purpose:** Represents an Azure Resource Group for grouping related networking resources.

2. **Azure Virtual Network (AKS-VNET):**
   - **Name:** `aks-vnet`
   - **Purpose:** Defines a Virtual Network for the Azure Kubernetes Service (AKS) cluster with the specified IP address space.

3. **Azure Subnet (Control Plane):**
   - **Name:** `control-plane-subnet`
   - **Purpose:** Represents the subnet for the AKS control plane, allocating IP addresses from the specified address range.

4. **Azure Subnet (Worker Node):**
   - **Name:** `worker-node-subnet`
   - **Purpose:** Represents the subnet for AKS worker nodes, allocating IP addresses from the specified range.

5. **Azure Network Security Group (AKS-NSG):**
   - **Name:** `aks-nsg`
   - **Purpose:** Defines a Network Security Group to control inbound and outbound traffic to the AKS cluster.

6. **Network Security Rule (kube-apiserver):**
   - **Name:** `kube-apiserver-rule`
   - **Purpose:** Allows inbound traffic on TCP port 443 to the kube-apiserver for AKS.

7. **Network Security Rule (SSH):**
   - **Name:** `ssh-rule`
   - **Purpose:** Allows inbound SSH traffic (TCP port 22) to the AKS cluster for administration purposes.

#### Step 4: 
The next step was to create the outputs.tf file. In this file a set of output variables are established to expose essential information about the networking resources, serving as valuable references for future configurations, providing easy access to crucial details about the infastructure.
The outputs are as follows:
1. **vnet_id**:
   - *Description*: ID of the Virtual Network (VNet).
   - *Value*: `azurerm_virtual_network.aks-vnet.id`

2. **control_plane_subnet_id**:
   - *Description*: ID of the control plane subnet.
   - *Value*: `azurerm_subnet.control-plane-subnet.id`

3. **worker_node_subnet_id**:
   - *Description*: ID of the worker node subnet.
   - *Value*: `azurerm_subnet.worker-node-subnet.id`

4. **resource_group_name**:
   - *Description*: Name of the Azure Resource Group for networking resources.
   - *Value*: `azurerm_resource_group.networking.id`

5. **aks_nsg_id**:
   - *Description*: ID of the Network Security Group (NSG) for AKS.
   - *Value*: `azurerm_network_security_group.aks-nsg.id`

#### Step 5: 
Now the essential files, variables, resources and outputs were created and defined it was time to initlaise the terraform project. To do this the following command is used.
```bash
terraform init
```
If done correctly a success message is displayed reading
```bash
oliv11111@LAPTOP-HM3O2P8O:~/aicore/Web-App-DevOps-Project/aks-terraform/networking-module$ terraform init

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
A quick step to check that the infastructure had been set up correctly is to run the terraform plan command. Typicaly one issue will display explaining the features block is missing, which is expected as that's the next stage, however in my case there were a few other issues in my terraform files
```bash
oliv11111@LAPTOP-HM3O2P8O:~/aicore/Web-App-DevOps-Project/aks-terraform/networking-module$ terraform plan
╷
│ Error: Unsupported attribute
│ 
│   on outputs.tf line 4, in output "vnet_id":
│    4:   value       = var.vnet_address_space.id
│     ├────────────────
│     │ var.vnet_address_space is a list of string
│ 
│ This value does not have any attributes.
╵
╷
│ Error: Reference to undeclared resource
│ 
│   on outputs.tf line 25, in output "aks_nsg_id":
│   25:   value       = azurerm_virtual_network.aks-nsg.id
│ 
│ A managed resource "azurerm_virtual_network" "aks-nsg" has not been declared in the root module.
╵
```
These were just simple syntax and variable name inconcistency errors which were cleaned up easily, however outline the importance of running this command.

#### Step 7: 
The final step, pushing to git. Typically I would leave this out, however in this milestone an issue worth noting was experienced.

After adding, comming and pushing to the terraform branch I recieved the following error
```bash
oliv11111@LAPTOP-HM3O2P8O:~/aicore/Web-App-DevOps-Project$ git push --set-upstream origin terraform
Enumerating objects: 17, done.
Counting objects: 100% (17/17), done.
Delta compression using up to 8 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (16/16), 53.97 MiB | 877.00 KiB/s, done.
Total 16 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote: error: Trace: d0e9df6ddec004d02e17ef94583cb7a49ac36c18215ab15e402b5e7814013a70
remote: error: See https://gh.io/lfs for more information.
remote: error: File aks-terraform/networking-module/.terraform/providers/registry.terraform.io/hashicorp/azurerm/3.89.0/linux_amd64/terraform-provider-azurerm_v3.89.0_x5 is 242.19 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.
To https://github.com/oliv11111/Web-App-DevOps-Project.git
 ! [remote rejected] terraform -> terraform (pre-receive hook declined)
```
The issue was that I was trying to commit above the allowed file size when using git. After some invesitgation I discovered it was the 'aks-terraform/networking-module/.terraform/providers/registry.terraform.io/hashicorp/azurerm/3.89.0/linux_amd64/terraform-provider-azurerm_v3.89.0_x5' file. Which after researching isn't essential.

If I hadn;t commited this file already I have added it to a .gitignore in the current branch, however it already was. So I created a new branch. Re-added the files and initalised the terraform project. Then before adding the changed, added the file path to the large file to .gitignore.

## For the Developer
### Benefits
1. **Abstraction of Complexity**: Developers can focus on code without deep Azure networking knowledge.
  
2. **Consistent Configurations**: Ensures reproducible environments, reducing potential issues.
  
3. **Scalability and Flexibility**: Easily scale and modify networking for changing application needs.
  
4. **Enhanced Collaboration**: Version-controlled infrastructure as code promotes collaboration.
  
5. **Security Best Practices**: NSGs and rules enforce security standards for AKS clusters.
  
6. **Time and Resource Efficiency**: Saves time by automating networking setup, minimizing errors.
  
7. **Ease of Maintenance**: Simplifies tracking and updating of networking configurations.
  

## Branch Information:

- The feature was implemented in a branch named `terraform-4`.

## For End-Users

### Benefits

1. **Reliability**: Ensures consistent and reliable network configurations for AKS clusters.
  
2. **Security Assurance**: Follows best practices with Network Security Groups (NSGs) and rules.
  
3. **Scalability and Performance**: Designed to accommodate scaling requirements without compromising performance.
  
4. **Reduced Downtime**: Reliable networking minimizes disruptions, enhancing user experience.
  
5. **Improved Application Responsiveness**: Optimized network configurations contribute to faster application response times.
  
6. **Transparent Updates**: Changes in the networking module can be implemented seamlessly without affecting end users.
  
7. **Secure Communication**: Enforces secure communication practices, protecting user data and interactions.


