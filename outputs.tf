output "sp_password" {
  value     = random_password.sp_password.result
  sensitive = true  # ✅ Marks as sensitive to avoid showing in logs
}
