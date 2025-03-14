terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.90.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.40.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azuread" {
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "infoblox_rg" {
  name     = "InfobloxOnboardingRGPoC"
  location = "North Europe"
}

resource "azuread_application" "infoblox_app" {
  display_name = "InfobloxDiscovery"
}

resource "azuread_service_principal" "infoblox_sp" {
 application_id = azuread_application.infoblox_app.application_id
}
resource "random_password" "sp_password" {
  length           = 32
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.infoblox_sp.id
  end_date_relative    = "8760h" # 1 year expiry
}


resource "azurerm_role_definition" "infoblox_dns_role" {
  name  = "Custom Infoblox Full Management"
  scope = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = [
        //  Read access to ALL Azure resources
        "*/read",

        //  Full DNS Zone Management
        "Microsoft.Network/dnsZones/read",
        "Microsoft.Network/dnsZones/write",
        "Microsoft.Network/dnsZones/delete",
        "Microsoft.Network/dnsZones/list/action",

        //  Full DNS Record Management (A, CNAME, TXT, MX, etc.)
        "Microsoft.Network/dnsZones/A/read",
        "Microsoft.Network/dnsZones/A/write",
        "Microsoft.Network/dnsZones/A/delete",
        "Microsoft.Network/dnsZones/CNAME/read",
        "Microsoft.Network/dnsZones/CNAME/write",
        "Microsoft.Network/dnsZones/CNAME/delete",
        "Microsoft.Network/dnsZones/TXT/read",
        "Microsoft.Network/dnsZones/TXT/write",
        "Microsoft.Network/dnsZones/TXT/delete",
        "Microsoft.Network/dnsZones/MX/read",
        "Microsoft.Network/dnsZones/MX/write",
        "Microsoft.Network/dnsZones/MX/delete",

        //  Full DNS Resolver Management
        "Microsoft.Network/dnsResolvers/read",
        "Microsoft.Network/dnsResolvers/write",
        "Microsoft.Network/dnsResolvers/delete",
        "Microsoft.Network/dnsResolvers/outboundEndpoints/read",
        "Microsoft.Network/dnsResolvers/outboundEndpoints/write",
        "Microsoft.Network/dnsResolvers/outboundEndpoints/delete",
        "Microsoft.Network/dnsResolvers/outboundEndpoints/join/action",

        //  Full DNS Forwarding Management
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

        //  Virtual Network Read Access (Needed for DNS)
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



