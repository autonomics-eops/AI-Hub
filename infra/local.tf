locals {
  resourceSuffix = "${var.appName}-${local.shortEnvironment[var.environment]}-${local.shortLocation[var.location]}-${var.instance}"
  shortSuffix    = "${var.appName}-${local.shortLocation[var.location]}-${var.instance}"
  storageSuffix  = lower("${var.appName}${local.shortEnvironment[var.environment]}${local.shortLocation[var.location]}${var.instance}")
  resourceNames = {
    # Resource Group
    rg = "rg-${local.resourceSuffix}"

    # Azure Monitor Private Link Scope
    ampls = "ampls-${local.resourceSuffix}"

    # API Management service
    apim = "apim-${local.resourceSuffix}"

    # Logic App (Standard)
    app = "app-${local.resourceSuffix}"

    # Application Insights
    appi = "appi-${local.resourceSuffix}"

    # App Service plan
    asp = "asp-${local.shortSuffix}"

    # API Connection
    apiconn = "azuremonitorlogs"

    # Azure Cosmos DB account
    cosmos                   = "cosmos-${local.resourceSuffix}"
    cosmos_database          = "ai-usage-db"
    cosmos_container_usage   = "ai-usage-container"
    cosmos_container_pricing = "model-pricing"
    cosmos_container_export  = "streaming-export-config"

    # Event Hubs Namespace
    eventhub_namespace = "evhns-${local.resourceSuffix}"
    eventhub           = "evh-${local.resourceSuffix}"

    # Managed Identity
    id = "id-${local.resourceSuffix}"

    # Log Analytics workspace
    law = "law-${local.resourceSuffix}"

    # Network security group
    nsg = "nsg-${local.resourceSuffix}"

    # Route Table
    rt = "rt-${local.resourceSuffix}"

    # Storage account
    storage = "st${local.storageSuffix}"

    # Share Name
    storage_share = "usage-logic-content"

    # Virtual network
    vnet = "vnet-${local.resourceSuffix}"
    snet = "snet-apim_aihub-prd-we-001"
  }

  shortEnvironment = {
    production  = "prd"
    test        = "tst"
    development = "dev"
    dta         = "dta"
  }

  shortLocation = {
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "southcentralus"     = "scus"
    "westus2"            = "wus2"
    "westus3"            = "wus3"
    "centralus"          = "cus"
    "northcentralus"     = "ncus"
    "westus"             = "wus"
    "eastasia"           = "eas"
    "southeastasia"      = "seas"
    "northeurope"        = "ne"
    "westeurope"         = "we"
    "uksouth"            = "uks"
    "ukwest"             = "ukw"
    "japaneast"          = "jpe"
    "japanwest"          = "jpw"
    "australiaeast"      = "aue"
    "australiasoutheast" = "ause"
    "australiacentral"   = "auc"
    "australiacentral2"  = "auc2"
    "canadacentral"      = "cac"
    "canadaeast"         = "cae"
    "centralindia"       = "cin"
    "southindia"         = "sin"
    "westindia"          = "win"
    "koreacentral"       = "korc"
    "koreasouth"         = "kors"
    "francecentral"      = "frc"
    "francesouth"        = "frs"
    "germanywestcentral" = "gwc"
    "germanynorth"       = "gn"
    "norwayeast"         = "nwe"
    "norwaywest"         = "nww"
    "switzerlandnorth"   = "chn"
    "switzerlandwest"    = "chw"
    "uaenorth"           = "uan"
    "uaecentral"         = "uac"
    "brazilsouth"        = "brs"
    "brazilsoutheast"    = "brse"
    "southafricanorth"   = "san"
    "southafricawest"    = "saw"
    "qatarcentral"       = "qat"
    "polandcentral"      = "plc"
    "israelcentral"      = "ilc"
    "swedencentral"      = "sec"
    "swedensouth"        = "ses"
    "italynorth"         = "itn"
    "spaincentral"       = "espc"
    "mexicocentral"      = "mexc"
  }


  tags = {
    environment_type    = local.shortEnvironment[var.environment]
    business_impact     = "high"
    business_capability = "aihublz"
    application_name    = "aihub"
    application_id      = "app00aihublz"
    opco                = "0002"
    ManagedBy           = "Terraform"
    DeployedBy          = "JDE-IT-AIHub"
  }

  private_dns_zone_names = [
    "privatelink.openai.azure.com",
    "privatelink.vaultcore.azure.net",
    "privatelink.monitor.azure.com",
    "privatelink.servicebus.windows.net",
    "privatelink.documents.azure.com",
    "privatelink.blob.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.queue.core.windows.net"
  ]

  identity_roles = [
    "Azure Event Hubs Data Owner",
    "Azure Event Hubs Data Sender",
    "Cognitive Services OpenAI User",
    "Monitoring Reader",
    "Storage Blob Data Owner"
  ]
}

data "azurerm_client_config" "current" {}
