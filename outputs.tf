#output "sp_password" {
#  value     = azuread_service_principal_password.sp_password.value
#  sensitive = true  # ✅ Marks as sensitive to hide in logs
#}

output "client_id" {
  description = "Azure AD Application (Service Principal) Client ID"
  value       = azuread_application.infoblox_app.application_id
}

output "tenant_id" {
  description = "Azure Tenant ID"
  value       = data.azurerm_client_config.current.tenant_id
}

