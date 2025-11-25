# Deployment Instructions

## Table of Contents

- [Deployment Instructions](#deployment-instructions)
  - [Table of Contents](#table-of-contents)
  - [Environment Setup](#environment-setup)
  - [Initial Provisioning](#initial-provisioning)
  - [Post-Provision Steps](#post-provision-steps)
  - [Final Steps and Notes](#final-steps-and-notes)
  - [Summary](#summary)

This guide describes how to provision the AI Hub Gateway Landing Zone and its components using the repository's Terraform-first approach. It preserves the original steps where relevant and updates the process to reflect that APIM nested resources and OpenAI deployments are managed by Terraform modules.

## Environment Setup

- Terraform (see infra/versions.tf for required range)
- Azure CLI (az) and an authentication method (interactive az login or CI service principal)
- Access to the Azure subscription and resource-group creation permission
- Ensure you have a copy of `terraform.tfvars` at the repository root (the repo includes a canonical non-sensitive default file)

## Initial Provisioning

1. Prepare terraform.tfvars
   - Edit root `terraform.tfvars` to set your environment values (appName, location, instance, environment, vnet CIDRs).
   - Edit the key variables that drive the infra:
     - openai_deployments
     - apim_backends
     - api_definitions
     - apim_subscriptions
     - apim_cache_version

2. Run Terraform from infra/
   - cd infra
   - terraform init
   - terraform fmt -check
   - terraform validate
   - terraform plan -var-file="../terraform.tfvars" -out plan.tfplan
   - terraform apply "plan.tfplan"

The infra module calls the following submodules: openai, apim, apis, subscriptions, cosmosdb, eventhub, logicapp, monitoring, networking, rbac.

## Post-Provision Steps

There are no manual post-deployment steps required for APIM or the OpenAI integration. All APIM nested resources are created and managed by Terraform. Specifically, Terraform (via infra/module/apim and related modules) now manages:

- APIM instance and nested objects
- Policy fragments (infra/module/apim/fragments/)
- Named values used by policies
- Loggers (Application Insights / Event Hub) wired into APIM
- Backends (apim_backends from terraform.tfvars)
- APIs and API policies (api_definitions and the apis module)
- Products and Subscriptions (infra/module/subscriptions via apim_subscriptions)

If any resource cannot be created automatically due to provider limitations, that exception will be documented in the relevant module README (infra/module/<module>/README.md). In normal operation, after a successful `terraform apply` from infra/ there should be no additional portal steps required to configure APIM assets or OpenAI deployments.

## Final Steps and Notes

- Ensure api_definitions point to the correct OpenAPI spec files in the repo (commonly under src/apis/ or the module-specific path). The apis module will register APIs from those specs during the apply.
- Policy fragments are stored in `infra/module/apim/fragments/`. Edit the XML files there and re-run Terraform to update fragments.
- When you add or change OpenAI instances or model_deployments that affect routing, increment `apim_cache_version` in `terraform.tfvars` to force APIM route/cluster refresh.
- Always verify exact parameter names and types in:
  - infra/var.tf
  - infra/module/<module>/var.tf

## Summary

- The repo is Terraform-first. Edit `terraform.tfvars` in the repo root and apply Terraform from `infra/`.
- APIM nested resources, OpenAI deployments and API policies are managed end-to-end by the repo's Terraform modules.
