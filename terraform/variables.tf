variable "location" {
  type    = string
  default = "eastus2"
}

variable "project_name" {
  type    = string
  default = "epicbook"
}

variable "resource_group_name" {
  type    = string
  default = "rg-epicbook-prod"
}

# Networking
variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "frontend_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "backend_subnet_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "db_subnet_cidr" {
  type    = string
  default = "10.10.3.0/24"
}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  description = "Admin and pipeline-agent public IPs allowed to SSH, e.g. [\"1.2.3.4/32\"]"
}

# Compute
variable "vm_size" {
  type    = string
  default = "Standard_D2als_v7"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  description = "Contents of the PUBLIC key (epicbook_key.pub)"
}

# Database
variable "mysql_sku_name" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "mysql_admin_username" {
  type = string
}

variable "mysql_admin_password" {
  type      = string
  sensitive = true
}
