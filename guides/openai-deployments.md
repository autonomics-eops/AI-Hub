# OpenAI Instance & Model Management

## Table of Contents

- [OpenAI Instance \& Model Management](#openai-instance--model-management)
  - [Table of Contents](#table-of-contents)
  - [Variable: `openai_deployments`](#variable-openai_deployments)
  - [Important: Adding a new OpenAI instance or deployment requires three coordinated updates](#important-adding-a-new-openai-instance-or-deployment-requires-three-coordinated-updates)
  - [Why this is required](#why-this-is-required)
  - [Validation \& troubleshooting](#validation--troubleshooting)
  - [Example full change workflow (concise)](#example-full-change-workflow-concise)
  - [Reference](#reference)

This guide documents how to manage Azure OpenAI instances and their model deployments via Terraform inputs and how to wire them into APIM backends. It also explains the required policy updates so APIM can route requests to new OpenAI clusters or new model deployments.

## Variable: `openai_deployments`

- Consumed by: infra/module/openai and referenced by infra/module/apim for backend routing.

Example (taken from repo `terraform.tfvars`):

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
      }
    ]
  }
}
```

## Important: Adding a new OpenAI instance or deployment requires three coordinated updates

When you add a new OpenAI instance or a new model deployment you must update all three places so APIM can route correctly:

1) Add the APIM backend entry to `apim_backends` in `terraform.tfvars`.  
   - Example addition:
  
   ```hcl
   apim_backends = [
     {
       name     = "backend-openai-001"
       protocol = "http"
       url      = "https://openai-aihub-prd-we-001.openai.azure.com/openai"
     },
     {
       name     = "backend-openai-002"
       protocol = "http"
       url      = "https://openai-aihub-prd-we-002.openai.azure.com/openai"
     }
   ]
   ```

2) Update the APIM API policy XML so the API knows about the new cluster/route(s). This is essential — adding a backend alone is not sufficient.
   - Policy location in this repo:
     - infra/module/apis/policies/azure-openai-service-api/azure-openai-service-api-policy.xml
   - In that file there is a C#-scripted block which builds the `oaClusters` and `routes` configuration (a cached configuration). You must add the new route object(s) to the `routes` array and add cluster entries that map deployment names to the appropriate routes.

3) Update Cosmos DB pricing_model so usage of the new deployment is reported with a base unit cost
   - Rationale: the system records usage and calculates cost using a pricing table in Cosmos DB (commonly named `pricing_model` or similar). When you add a new deployment model, you must create a corresponding pricing entry so collected usage can be converted to cost and displayed correctly in dashboards and billing reports.
   - For the exact steps and example pricing document, see the upstream Power BI Dashboard guide (always up-to-date link):
     https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator/blob/main/guides/power-bi-dashboard.md

4) Bump `apim_cache_version` in `terraform.tfvars`
   - Update the cache version so APIM drops the old cluster/route cache and rebuilds it with the updated policy logic.

   ```hcl
   apim_cache_version = "v20250817"
   ```

5) Apply Terraform
   - cd infra
   - terraform init (if needed)
   - terraform plan -var-file="../terraform.tfvars"
   - terraform apply -var-file="../terraform.tfvars"

Terraform will update:

- APIM backends (infra/module/apim)
- API policy/fragments (infra/module/apis and infra/module/apim as configured)
- OpenAI deployments (infra/module/openai) if you added/changed them

## Why this is required

- APIM backends created by Terraform add the endpoint objects, but the API policy contains the inlined routing logic (the `oaClusters`/`routes` structure) that determines which backend is chosen for a given deployment name, path or header. If you only add the backend in Terraform but do not update the policy (and the pricing model in Cosmos DB), runtime routing and cost aggregation will not include the new deployment.

## Validation & troubleshooting

- Validate XML/C# script syntax carefully — syntax errors inside the policy block will cause the APIM policy deployment to fail.
- Confirm `deploymentName` values exactly match the `name` in `openai_deployments`.
- Confirm `backend-id` values exactly match the `name` values in `apim_backends`.
- Confirm that the new `pricing_model` document is present in Cosmos DB and matches the schema expected by the ingestion/aggregation pipeline and Power BI.
- If routing still points to an old backend:
  - Ensure `apim_cache_version` was bumped and Terraform was applied.
  - Inspect the composed policy in Azure Portal (API Management → APIs → API → Policies) to verify the updated `oaClusters`/`routes`.
- Verify costs in Power BI:
  - After usage is ingested, ensure the dashboard shows cost lines for the new deployment; if not, check the pricing_model entry and ingestion pipeline.

## Example full change workflow (concise)

1. Edit root `terraform.tfvars`:
   - Add backend to `apim_backends`.
   - Add deployment to `openai_deployments` (if adding a model).
2. Edit `infra/module/apis/policies/azure-openai-service-api/azure-openai-service-api-policy.xml`:
   - Add `routes.Add(...)` and `clusters.Add(...)` entries in the oaClusters building block.
3. Add a pricing entry for the new deployment to the Cosmos DB `pricing_model` collection (see the upstream Power BI Dashboard guide for examples).
4. Bump `apim_cache_version` in `terraform.tfvars`.
5. From `infra/`: terraform plan/apply with your var file.
6. Verify routes and cost reporting in APIM and Power BI.

## Reference

- Policy file: `infra/module/apis/policies/azure-openai-service-api/azure-openai-service-api-policy.xml`
- Backend fragments: `infra/module/apim/fragments/`
- Pricing model: Cosmos DB `pricing_model` collection (see the upstream Power BI Dashboard guide for examples and insertion steps)
- Variables: `infra/var.tf`, `infra/module/apim/variables.tf`, `infra/module/apis/variables.tf`