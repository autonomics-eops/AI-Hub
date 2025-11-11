# Managing API Management Products & Subscriptions

## Table of Contents

- [Managing API Management Products \& Subscriptions](#managing-api-management-products--subscriptions)
  - [Table of Contents](#table-of-contents)
  - [📦 Define Subscriptions as Code](#-define-subscriptions-as-code)
    - [Terraform Variable: `apim_subscriptions`](#terraform-variable-apim_subscriptions)
    - [HCL Example (terraform.tfvars)](#hcl-example-terraformtfvars)
  - [➕ Add a New Subscription and Product](#-add-a-new-subscription-and-product)
  - [➖ Remove or Suspend a Subscription](#-remove-or-suspend-a-subscription)
    - [❌ Remove a Subscription](#-remove-a-subscription)
    - [🚫 Suspend or Disable a Subscription](#-suspend-or-disable-a-subscription)
  - [🔐 Restrict Access to Specific Models](#-restrict-access-to-specific-models)
    - [Model RBAC Policy (fragment: frag-model-rbac)](#model-rbac-policy-fragment-frag-model-rbac)
    - [How to Restrict Model Access](#how-to-restrict-model-access)
  - [📉 Apply Token Limits per Subscription](#-apply-token-limits-per-subscription)
    - [Token Limits Policy (fragment: frag-token-limits)](#token-limits-policy-fragment-frag-token-limits)
    - [How to Apply a Custom Token Limit](#how-to-apply-a-custom-token-limit)
  - [Notes and Operational Scenarios (preserved)](#notes-and-operational-scenarios-preserved)
  - [Validation \& Troubleshooting](#validation--troubleshooting)
  - [References](#references)

The AI Hub Gateway uses **Azure API Management (APIM)** to securely manage access to Azure OpenAI. Each team or consumer receives a dedicated **APIM Product** and an associated **APIM Subscription**, which are managed as code.

This document explains how to:

- Define and deploy subscriptions and products via `apim_subscriptions`
- Restrict model access per subscription
- Apply token-per-minute (TPM) limits per subscription

## 📦 Define Subscriptions as Code

Subscriptions and their associated products are declared using the `apim_subscriptions` variable in Terraform and are applied from the repository's `infra/` Terraform workspace.

### Terraform Variable: `apim_subscriptions`

The module expects a list of subscription/product objects. Example type (see `infra/module/subscriptions/var.tf` for the authoritative schema):

```hcl
variable "apim_subscriptions" {
  description = "List of API Management Subscriptions with a dedicated product"
  type = list(object({
    product_id                 = string
    product_display_name       = string
    product_published          = optional(bool, true)
    subscription_id            = string
    subscription_display_name  = string
    subscription_state         = optional(string, "active")
    subscription_allow_tracing = optional(bool, false)
  }))
  default = []
}
```

### HCL Example (terraform.tfvars)

Edit the root `terraform.tfvars` (this repository uses the root terraform.tfvars as the canonical place for these inputs). Here is an example taken from the repo:

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
  }
]
```

After editing `terraform.tfvars`, run Terraform from the infra folder:

```bash
cd infra
terraform init
terraform fmt -check
terraform validate
terraform plan -var-file="../terraform.tfvars" -out plan.tfplan
terraform apply "plan.tfplan"
```

This will create:

- APIM Products
- APIM Subscriptions attached to those products
- Any product-level policies or links the subscriptions module is configured to apply

---

## ➕ Add a New Subscription and Product

1. Add a new object to the `apim_subscriptions` list in the root `terraform.tfvars`.
2. From `infra/` run the terraform plan/apply sequence above.
3. Add a new subscription Id,Token limits in guides/active-subscriptions.md file. 

Result:

- A new APIM Product and Subscription will be created and associated with the API according to the module configuration.

---

## ➖ Remove or Suspend a Subscription

### ❌ Remove a Subscription

- Delete the corresponding object from `apim_subscriptions` in `terraform.tfvars`.
- Run Terraform apply from `infra/`.
- The product/subscription will be removed (confirm removal behavior in `infra/module/subscriptions` README if you need to preserve analytics or keys).

### 🚫 Suspend or Disable a Subscription

- Change `subscription_state` in the `apim_subscriptions` object to an appropriate value supported by the module/provider (for example, `"suspended"` or `"cancelled"`).
- Run Terraform apply from `infra/`.

Note: Check `infra/module/subscriptions/var.tf` and the provider behavior for the exact allowed states and effects.

---

## 🔐 Restrict Access to Specific Models

Model-level access controls are enforced using the policy fragment `frag-model-rbac`. The fragment name and deployment path are managed in the repository and deployed by Terraform as part of the APIM module.

### Model RBAC Policy (fragment: frag-model-rbac)

Fragment path in this repo:

- infra/module/apim/fragments/frag-model-rbac.xml

Example fragment content (update subscription lists to match your environment):

```xml
<choose>
  <!-- Allow specific subscriptions to use 'test-model' -->
  <when condition='@(
      new [] { "sub-ccoe", "sub-test" }.Contains(context.Subscription.Id) && 
      (string)context.Variables["deployment-id"] != "test-model"
  )'>
    <return-response>
      <set-status code="403" reason="Forbidden" />
      <set-body>@("This subscription is only authorized to use 'test-model'.")</set-body>
    </return-response>
  </when>

  <!-- Prevent unauthorized subscriptions from calling 'test-model' -->
  <when condition='@(
      !(new [] { "sub-ccoe", "sub-test" }.Contains(context.Subscription.Id)) && 
      (string)context.Variables["deployment-id"] == "test-model"
  )'>
    <return-response>
      <set-status code="403" reason="Forbidden" />
      <set-body>@("Access to 'test-model' is restricted for your subscription.")</set-body>
    </return-response>
  </when>
</choose>
```

### How to Restrict Model Access

1. Edit `infra/module/apim/fragments/frag-model-rbac.xml`:
   - Add or remove subscription IDs in the logic to reflect who can access each model.
   - Ensure `deployment-id` used in the fragment matches how your API sets that variable (matched parameter, header, etc.).
2. Deploy the change by running Terraform from `infra/`:
   - The APIM module will pick up the fragment file changes and update policy fragments during apply.

Do not update fragments manually in the portal unless you have a documented exception: fragments are repository-managed and should be updated via versioned changes in the repo.

---

## 📉 Apply Token Limits per Subscription

Token-per-minute (TPM) limits are enforced using the policy fragment `frag-token-limits`.

### Token Limits Policy (fragment: frag-token-limits)

Fragment path in this repo:

- infra/module/apim/fragments/frag-token-limits.xml

Example fragment content (adjust subscription IDs and TPM values as needed):

```xml
<choose>
  <!-- Strict limit for specific subscription -->
  <when condition='@((string)context.Subscription.Id == "subscription-ccoe")'>
    <azure-openai-token-limit counter-key='@((string)context.Subscription.Id)' tokens-per-minute='1'
      estimate-prompt-tokens='false'
      tokens-consumed-variable-name='consumed-tokens'
      remaining-tokens-variable-name='remaining-tokens'
      retry-after-header-name='retry-after' />
  </when>

  <!-- Default TPM limit for all other subscriptions -->
  <otherwise>
    <azure-openai-token-limit counter-key='APIMOpenAI' tokens-per-minute='250000'
      estimate-prompt-tokens='false'
      tokens-consumed-variable-name='consumed-tokens'
      remaining-tokens-variable-name='remaining-tokens'
      retry-after-header-name='retry-after' />
  </otherwise>
</choose>
```

### How to Apply a Custom Token Limit

1. Edit `infra/module/apim/fragments/frag-token-limits.xml`.
   - Add a `<when>` block for the subscription ID and set `tokens-per-minute` to the desired value.
2. Run Terraform from `infra/` to deploy the updated fragment.

---

## Notes and Operational Scenarios (preserved)

- Adding a TPM limit, restricting a model, allowing a model, suspending a subscription, or removing a subscription are all supported operational scenarios and are still valid.
- The key change: fragment names are prefixed with `frag-` and fragments are deployed/managed by Terraform under `infra/module/apim/fragments/`. Do not edit fragments only in the portal—edit the files in the repository and apply Terraform.
- Always validate the fragment XML and any C# policy script blocks (if present) — syntax errors will cause APIM policy deployment to fail.

## Validation & Troubleshooting

- Confirm that `subscription_id` values in `apim_subscriptions` match the subscription identifiers you expect to see in APIM.
- After apply, review APIM Products and Subscriptions in the Azure Portal to confirm state and key issuance.
- If a product/subscription does not behave as expected, check:
  - The composed API policy (Portal → API Management → APIs → API → Policies)
  - Fragment files under `infra/module/apim/fragments/`
  - The `infra/module/subscriptions` module README for provider-specific behaviors

---

## References

- APIM fragments: infra/module/apim/fragments/
- Subscriptions module variables: infra/module/subscriptions/var.tf
- Top-level variables: infra/var.tf
