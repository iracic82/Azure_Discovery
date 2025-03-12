provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "infoblox_rg" {
  name     = "InfobloxOnboardingRG"
  location = "East US"
}

resource "azuread_application" "infoblox_app" {
  display_name = "InfobloxDiscovery"
}

resource "azuread_service_principal" "infoblox_sp" {
  application_id = azuread_application.infoblox_app.application_id
}

resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.infoblox_sp.id
  value                = "SuperSecretPassword123!" # Generate securely!
  end_date_relative    = "8760h" # 1 year expiry
}

resource "azurerm_role_definition" "infoblox_dns_role" {
  name  = "Custom DNS Resolver Full Management"
  scope = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = [
      "Microsoft.Network/dnsResolvers/read",
      "Microsoft.Network/dnsResolvers/write",
      "Microsoft.Network/dnsResolvers/delete",
      "Microsoft.Network/dnsResolvers/outboundEndpoints/read",
      "Microsoft.Network/dnsResolvers/outboundEndpoints/write",
      "Microsoft.Network/dnsResolvers/outboundEndpoints/delete",
      "Microsoft.Network/dnsResolvers/outboundEndpoints/join/action",
      "Microsoft.Network/dnsForwardingRulesets/read",
      "Microsoft.Network/dnsForwardingRulesets/write",
      "Microsoft.Network/dnsForwardingRulesets/delete",
      "Microsoft.Network/dnsForwardingRulesets/join/action",
      "Microsoft.Network/dnsForwardingRulesets/forwardingRules/read",
      "Microsoft.Network/dnsForwardingRulesets/forwardingRules/write",
      "Microsoft.Network/dnsForwardingRulesets/forwardingRules/delete",
      "Microsoft.Network/dnsForwardingRulesets/virtualNetworkLinks/read",
      "Microsoft.Network/dnsForwardingRulesets/virtualNetworkLinks/write",
      "Microsoft.Network/dnsForwardingRulesets/virtualNetworkLinks/delete",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/listDnsResolvers/action",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/virtualNetworks/subnets/join/action"
    ]
  }

  assignable_scopes = ["/subscriptions/${var.subscription_id}"]
}

resource "azurerm_role_assignment" "infoblox_role_assignment" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = azurerm_role_definition.infoblox_dns_role.name
  principal_id         = azuread_service_principal.infoblox_sp.id
}

output "client_id" {
  value = azuread_application.infoblox_app.application_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}
