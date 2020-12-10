# Ensure that you are logged into the Azure CLI prior to running this.
# Incase it's not obvious, anything that has "CHANGEME" in the name needs
# needs to be changed. 
# Demo tags on all the elements that will accept them.
# This is 100% unofficial and not supported by Rubrik.

# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "CHANGEME-rg-name" {
  name     = "CHANGEME-rg-name"
  location = "CHANGEME-AzureRegion"

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

# Create a virtual network within the resource group - set the desired address space to
# whatever subnet you want to use
resource "azurerm_virtual_network" "CHANGEME-vnet-name" {
  name                = "CHANGEME-vnet-name"
  resource_group_name = azurerm_resource_group.CHANGEME-rg-name.name
  location            = azurerm_resource_group.CHANGEME-rg-name.location
  address_space       = ["172.16.1.0/24"]

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

# Create network security group for external access to CC
# Not required but eases access during the bootstrap process
# YMMV depending on security constraints/concerns
# I typically just grant SSH and HTTPS access from my IP address
# during the bootstrap/config process
resource "azurerm_network_security_group" "CHANGEME-nsg-name" {
  name                = "CHANGEME-nsg-name"
  resource_group_name = azurerm_resource_group.CHANGEME-rg-name.name
  location            = azurerm_resource_group.CHANGEME-rg-name.location

  security_rule {
    name              = "allow_ssh_https_from_home"
    priority          = 100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "TCP"
    source_port_range = "*"
    destination_port_ranges = [
      "22",
      "443",
    ]
    source_address_prefix      = "CHANGEME-ip-address"
    destination_address_prefix = "*"
  }

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

# Create subnets - I like to create one for hosts and one for the Cloud Cluster
# This keeps the Cloud Cluster on it's own L2 domain
resource "azurerm_subnet" "CHANGEME-subnet1" {
  name                 = "CHANGEME-subnet1"
  resource_group_name  = azurerm_resource_group.CHANGEME-rg-name.name
  virtual_network_name = azurerm_virtual_network.CHANGEME-vnet-name.name
  address_prefix       = "172.16.1.32/27"
}

resource "azurerm_subnet" "CHANGEME-subnet2" {
  name                 = "CHANGEME-subnet2"
  resource_group_name  = azurerm_resource_group.CHANGEME-rg-name.name
  virtual_network_name = azurerm_virtual_network.CHANGEME-vnet-name.name
  address_prefix       = "172.16.1.64/26"
}

# Assign NSG to CC Subnet
resource "azurerm_subnet_network_security_group_association" "CHANGEME-subnet1" {
  subnet_id                 = azurerm_subnet.CHANGEME-subnet1.id
  network_security_group_id = azurerm_network_security_group.CHANGEME-nsg-name.id
}

# Create storage accounts for Cloud Cluster image
resource "azurerm_storage_account" "CHANGEME-storageacc-name" {
  name                     = "CHANGEME-storageacc-name"
  resource_group_name      = azurerm_resource_group.CHANGEME-rg-name.name
  location                 = azurerm_resource_group.CHANGEME-rg-name.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

# Create public IP for node 1 - change this to whatever matches customer naming
# conventions for public IP addresses
# Again YMMV whether this is required due to security constraints but for testing
# and bootstrap purposes it is useful to have around
resource "azurerm_public_ip" "cc-nic-01-pub" {
  name                = "cc-nic-01-pub"
  resource_group_name = azurerm_resource_group.CHANGEME-rg-name.name
  location            = azurerm_resource_group.CHANGEME-rg-name.location
  allocation_method   = "Static"

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

# create cloud cluster NICs
resource "azurerm_network_interface" "cc-nic-01" {
  name                          = "cc-nic-01"
  location                      = azurerm_resource_group.CHANGEME-rg-name.location
  resource_group_name           = azurerm_resource_group.CHANGEME-rg-name.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.CHANGEME-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.cc-nic-01-pub.id
  }

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

resource "azurerm_network_interface" "cc-nic-02" {
  name                          = "cc-nic-02"
  location                      = azurerm_resource_group.CHANGEME-rg-name.location
  resource_group_name           = azurerm_resource_group.CHANGEME-rg-name.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.CHANGEME-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

resource "azurerm_network_interface" "cc-nic-03" {
  name                          = "cc-nic-03"
  location                      = azurerm_resource_group.CHANGEME-rg-name.location
  resource_group_name           = azurerm_resource_group.CHANGEME-rg-name.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.CHANGEME-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}

resource "azurerm_network_interface" "cc-nic-04" {
  name                          = "cc-nic-04"
  location                      = azurerm_resource_group.CHANGEME-rg-name.location
  resource_group_name           = azurerm_resource_group.CHANGEME-rg-name.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.CHANGEME-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    project = "terraform templates"
    owner   = "ed"
  }
}
