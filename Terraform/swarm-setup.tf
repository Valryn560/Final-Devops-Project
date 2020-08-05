provider "azurerm" {
version = "=2.0.0"
features {}
}

variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "main" {
  name     = "FinalRG"
  location = "uksouth"
}

resource "azurerm_virtual_network" "main" {
  name                  = "terravn"
  address_space         = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "tfpublicip" {
  name                         = "PIP1"
  location                     = "uksouth"
  resource_group_name          = "FinalRG"
  allocation_method  = "Static"

  tags = {
    environment = "development"
  }
}

resource "azurerm_public_ip" "tfpublicip2" {
  name                         = "PIP2"
  location                     = "uksouth"
  resource_group_name          = "FinalRG"
  allocation_method  = "Static"

  tags = {
    environment = "development"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "terraformNIC"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.tfpublicip.id
  }
}

resource "azurerm_network_interface" "worker" {
  name                = "terraformNIC2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.tfpublicip2.id
  }
}

resource "azurerm_linux_virtual_machine" "manager" {
  name                = "manager"
  resource_group_name = "FinalRG"
  location            = "uksouth"
  size                = "Standard_F2"
  admin_username      = "Team2"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "Team2"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "worker" {
  name                = "worker"
  resource_group_name = "FinalRG"
  location            = "uksouth"
  size                = "Standard_F2"
  admin_username      = "Team2"
  network_interface_ids = [
    azurerm_network_interface.worker.id,
  ]

  admin_ssh_key {
    username   = "Team2"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}