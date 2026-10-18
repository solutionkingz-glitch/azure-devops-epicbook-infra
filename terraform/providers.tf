provider "azurerm" {
  features {}
  # Subscription, tenant and client credentials are NOT written here.
  # They come from environment variables (ARM_*) supplied by the
  # pipeline's service connection, or from `az login` locally.
}
