output "sp_password" {
  value     = azuread_service_principal_password.sp_password.value
  sensitive = true  # ✅ Marks as sensitive to hide in logs
}

#output "client_id" {
#  value = azuread_application.infoblox_app.application_id
#}
output "client_id" {
  description = "Client ID of the Terraform authenticated Service Principal"
  value       = data.azurerm_client_config.current.client_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

