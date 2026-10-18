terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-epicbook"
    storage_account_name = "stepicbook1721419177"
    container_name       = "tfstate"
    key                  = "epicbook.tfstate"
    use_azuread_auth     = true
  }
}
