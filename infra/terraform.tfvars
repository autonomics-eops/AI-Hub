appName     = "aihub"
location    = "eastus"
instance    = "001"
environment = "production"

vnet_address_prefix                    = "10.253.144.0/24"
apim_subnet_address_prefix             = "10.253.144.0/26"
private_endpoint_subnet_address_prefix = "10.253.144.64/26"
function_app_subnet_address_prefix     = "10.253.144.128/26"

openai_deployments = {
  openai = {
    location = "westeurope"
    model_deployments = [
      {
        name = "chat"
        model = {
          format  = "OpenAI"
          name    = "gpt-4o-mini"
          version = "2024-07-18"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 250
        }
      },
      {
        name = "embedding"
        model = {
          format  = "OpenAI"
          name    = "text-embedding-3-large"
          version = "1"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 250
        }
      },
      {
        name = "text-embedding-ada-002"
        model = {
          format  = "OpenAI"
          name    = "text-embedding-ada-002"
          version = "2"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 1000
        }
      },
      {
        name = "gpt-4o"
        model = {
          format  = "OpenAI"
          name    = "gpt-4o"
          version = "2024-11-20"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 1000
        }
      },
      {
        name = "gpt-41"
        model = {
          format  = "OpenAI"
          name    = "gpt-4.1"
          version = "2025-04-14"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 250
        }
      },
      {
        name = "gpt-41-mini"
        model = {
          format  = "OpenAI"
          name    = "gpt-4.1-mini"
          version = "2025-04-14"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 250
        }
      },
      {
        name = "gpt-41-nano"
        model = {
          format  = "OpenAI"
          name    = "gpt-4.1-nano"
          version = "2025-04-14"
        }
        sku = {
          name     = "GlobalStandard"
          capacity = 250
        }
      }
    ]
  }
}

apim_backends = [
  {
    name     = "backend-openai-001"
    protocol = "http"
    url      = "https://openai-aihub-prd-we-001.openai.azure.com/openai"
  },
  {
    name     = "backend-search-001"
    protocol = "http"
    url      = "https://placeholder.com/uri"
  }
]

api_definitions = {
  azure-openai-service-api = {
    api_path     = "openai"
    display_name = "Azure OpenAI Service API"
    description  = "Azure OpenAI APIs for completions and search"
    content_format = "openapi"
  }
  azure-openai-service-api-preview = {
    api_path     = "openai-prev12"
    display_name = "Azure OpenAI API - prev12"
    description  = "Azure OpenAI APIs for completions and search"
    content_format = "openapi"
    isPreview    = true
  }
  #azure-ai-search-api = {
  #  api_path     = "search"
  #  display_name = "Azure Search Index"
  #  description  = "Client that can be used to query an index and upload, merge, or delete documents."
  #}
  #ai-model-inference-api = {
  #  api_path     = "model"
  #  display_name = "AI Model Interence API"
  #  description  = "AI Model Interence API"
  #}
}


apim_subscriptions = [
  {
    product_id                 = "genwizard"
    product_display_name       = "GenWizard"
    product_published          = true
    subscription_id            = "genwizard"
    subscription_display_name  = "GenWizard"
    subscription_state         = "active"
    subscription_allow_tracing = false
  },
  {
    product_id                 = "hcl-aex"
    product_display_name       = "hcl-aex"
    product_published          = true
    subscription_id            = "hcl-aex"
    subscription_display_name  = "AEX - GenAI cognitive chatbot Technology Services"
    subscription_state         = "active"
    subscription_allow_tracing = false
  },
  {
    product_id                 = "chatbot"
    product_display_name       = "MSFT chatbot"
    product_published          = true
    subscription_id            = "chatbot"
    subscription_display_name  = "MSFT chatbot"
    subscription_state         = "active"
    subscription_allow_tracing = false
  },
  {
    product_id                 = "nextgen"
    product_display_name       = "nextgen"
    product_published          = true
    subscription_id            = "nextgen"
    subscription_display_name  = "nextgen"
    subscription_state         = "active"
    subscription_allow_tracing = false
  },
  {
    product_id                 = "hcl-aex-prd"
    product_display_name       = "hcl-aex-prd"
    product_published          = true
    subscription_id            = "hcl-aex-prd"
    subscription_display_name  = "AEX - GenAI cognitive chatbot Technology Services for production"
    subscription_state         = "active"
    subscription_allow_tracing = false
  }
]

apim_cache_version = "v20250901"

