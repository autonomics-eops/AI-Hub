# Understanding APIM Assets

## Table of Contents

- [Understanding APIM Assets](#understanding-apim-assets)
  - [Table of Contents](#table-of-contents)
  - [🛠️ Operational Notes](#️-operational-notes)
  - [🔐 Named Values](#-named-values)
  - [🧩 Policy Fragments](#-policy-fragments)
  - [📜 Loggers](#-loggers)
  - [🔁 Backends](#-backends)
  - [🔌 APIs](#-apis)
    - [Policy Flow](#policy-flow)
    - [Dependencies](#dependencies)
  - [🔌 OpenAI API Policy](#-openai-api-policy)
  - [📦 Subscriptions and Products](#-subscriptions-and-products)
  - [🔗 Additional Resources](#-additional-resources)

This guide explains APIM assets (named values, policy fragments, loggers, backends, APIs, products & subscriptions) and how they are managed in the Terraform-first flow introduced by ApiManagement_v2.

## 🛠️ Operational Notes

- APIM instance and nested objects are created by infra/module/apim.
- Policy fragments live in infra/module/apim/fragments/ and are applied by Terraform. Fragment filenames and IDs in this repo use the `frag-` prefix (e.g., frag-models-list).
- When updating fragments, change the file and run terraform apply from infra/.

## 🔐 Named Values

- Named values are created by the APIM module and often referenced by policy fragments.
- Manage non-sensitive named values in terraform.tfvars. Keep secrets out of repo tfvars — use your secret store or environment variables.
- The APIM module will create named values from variables referenced in infra/var.tf.
- If you need to add a named value, update the relevant variable or module input and apply Terraform.
- See infra/module/apim/named_values.tf and infra/module/apim/var.tf for currently defined keys to edit.

## 🧩 Policy Fragments

- Location: infra/module/apim/fragments/
- Naming: files/IDs are prefixed with `frag-`
- Common fragments included in the repo:
  - frag-models-list.xml
  - frag-deployments-list.xml
  - frag-token-limits.xml
  - frag-model-rbac.xml
  - frag-openai-usage.xml
  - frag-backend-routing.xml
- When referencing fragments in API policies, use the exact fragment ID (frag-...).

## 📜 Loggers

- Loggers (Application Insights, Event Hub) are created by the monitoring/eventhub modules and wired into APIM by the APIM module.
- Check infra/module/monitoring and infra/module/eventhub for logger resource names and how they map to APIM.

## 🔁 Backends

- APIM backends are defined via the apim_backends variable in terraform.tfvars and created by infra/module/apim.
- Do not invent unsupported fields in the backend objects; use the schema in infra/module/apim/var.tf.
- Example (from repo terraform.tfvars):
  - backend-openai-001 → https://openai-aihub-prd-we-001.openai.azure.com/openai
  - backend-search-001 → https://placeholder.com/uri

## 🔌 APIs

- APIs are created via the apis module and the api_definitions variable. Each api_definition entry wires an OpenAPI spec into APIM.
- Make sure the spec path and the backend key are consistent with the repo layout and apim_backends entries.

### Policy Flow

- APIM policy execution frequently references fragments. The repo deploys fragments and named values that fragments depend on.
- If a policy references a fragment that does not exist, the APIM policy deployment will fail — ensure fragments are present and named correctly.

### Dependencies

- The APIM module depends on loggers/named values/backends for successful policy execution. Ensure those objects exist or are created in the same apply.

## 🔌 OpenAI API Policy

- OpenAI-specific policy logic (rate limiting, model RBAC, usage logging) is implemented with fragment names prefixed by frag- as described above.
- Use apim_cache_version to invalidate APIM route mapping caches after changes to OpenAI instances or deployments.

## 📦 Subscriptions and Products

- Products and Subscriptions are created by infra/module/subscriptions using the apim_subscriptions variable.
- The subscriptions module supports product-level policies referencing fragments such as frag-token-limits and frag-model-rbac.

## 🔗 Additional Resources

- infra/var.tf
- infra/module/apim/var.tf
- infra/module/subscriptions/var.tf
- infra/module/apis/var.tf