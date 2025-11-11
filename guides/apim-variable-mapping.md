# Variable mapping cheat-sheet — JDE-IT-AIHUB (real examples)

This cheat-sheet shows the most commonly edited top-level variables from your repository's terraform.tfvars with real-life values taken directly from your file. Use these as copy/paste-ready examples and as a reminder of where each variable is consumed.

Always validate exact field shapes in:

- infra/var.tf
- infra/module/<module>/var.tf

---

1) openai_deployments

   - Purpose: Declare Azure OpenAI deployments/models per logical instance.
   - Consumed by: infra/module/openai and referenced by infra/module/apim for backend mapping.

Example (copied from terraform.tfvars)

    ```hcl
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
            capacity = 250
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
            capacity = 250
            }
        }]}
    }
    ```

Notes:

- To add a model for the existing `openai` instance: append an object to model_deployments for the `openai` key.
- To add a new OpenAI instance: add a new top-level key similar to `openai` with its properties.
- Avoid placing secrets in terraform.tfvars. Use secure storage for keys.

  1) apim_backends

     - Purpose: Define APIM backend endpoints APIM will route to.
     - Consumed by: infra/module/apim (creates APIM backend resources).
     - Important: your apim_backends in terraform.tfvars does not include any auth block — do not invent an auth section unless the module supports it.

      Example (copied from terraform.tfvars)

    ```hcl
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
    ```

    Notes:

    - Keep the backend `name` stable and reference it from api_definitions or API policy mappings.
    - If authentication is required by a backend, consult infra/module/apim/var.tf for the supported auth schema — do not add fields unless supported.


  2) api_definitions

  - Purpose: Drive API registration in APIM; modules create APIs based on these entries.
  - Consumed by: infra/module/apis (looped from infra/main.tf).

  Example (copied from terraform.tfvars)
  ```hcl
  api_definitions = {
    azure-openai-service-api = {
      api_path     = "openai"
      display_name = "Azure OpenAI API"
      description  = "Azure OpenAI API"
    }
    azure-ai-search-api = {
      api_path     = "search"
      display_name = "Azure Search Index"
      description  = "Client that can be used to query an index and upload, merge, or delete documents."
    }
  }
  ```

Notes:
- Ensure your OpenAPI spec files (if used) are placed where the module expects them (e.g., `src/apis/` or module-specific location).
- Add backend binding or policy references only if the module supports those fields; check infra/module/apis/var.tf.

---

1) apim_subscriptions (products & subscriptions)

- Purpose: Create APIM Products and Subscriptions.
- Consumed by: infra/module/subscriptions.

Example (copied from terraform.tfvars)

```hcl
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
    product_id                 = "hcl-aex-prd"
    product_display_name       = "hcl-aex-prd"
    product_published          = true
    subscription_id            = "hcl-aex-prd"
    subscription_display_name  = "AEX - GenAI cognitive chatbot Technology Services"
    subscription_state         = "active"
    subscription_allow_tracing = false
  }
]
```

Notes:
- Each object represents a product and a subscription as per your module's schema. If you need additional properties (quota, policies), confirm them in infra/module/subscriptions/var.tf.

---

1) apim_cache_version
- Purpose: Control APIM route/cache refreshes after topology changes (e.g., new OpenAI instances or model deployments).
- Consumed by: infra/module/apim.

Example (copied from terraform.tfvars)

```hcl
apim_cache_version = "v20250816"
```

Notes:
- Increment or change this value whenever you add/remove OpenAI instances or model_deployments that alter APIM routing so APIM picks up updated cluster mappings.

---

Contextual variables (top-level repo settings — copied)

```hcl
appName     = "aihub"
location    = "westeurope"
instance    = "001"
environment = "production"

vnet_address_prefix                   = "10.253.144.0/24"
apim_subnet_address_prefix            = "10.253.144.0/26"
private_endpoint_subnet_address_prefix = "10.253.144.64/26"
function_app_subnet_address_prefix    = "10.253.144.128/26"
```

---

Quick workflow recap
1. Edit terraform.tfvars (root) — use the examples above as templates.
2. From infra/:
   - terraform init
   - terraform plan -var-file="../terraform.tfvars"
   - terraform apply -var-file="../terraform.tfvars"
3. Verify APIM, OpenAI, and other resources in Azure Portal.

---

Final note
- This document strictly uses the values you provided in terraform.tfvars and avoids inventing any unsupported fields (e.g., auth blocks in apim_backends). For exact field-level validation before you apply changes, consult infra/var.tf and infra/module/*/var.tf.