output "sp_password" {
  value     = azuread_service_principal_password.sp_password.value
  sensitive = true  # ✅ Marks as sensitive to hide in logs
}
