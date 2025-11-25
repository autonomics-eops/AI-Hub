# 📊 AI Hub Power BI Dashboard

## Table of Contents

- [📊 AI Hub Power BI Dashboard](#-ai-hub-power-bi-dashboard)
  - [Table of Contents](#table-of-contents)
  - [📁 Dashboard File Location](#-dashboard-file-location)
  - [⚠️ Prerequisites](#️-prerequisites)
    - [✅ 1. Your IP Can Access CosmosDB](#-1-your-ip-can-access-cosmosdb)
    - [✅ 2. Set Correct Power BI Credentials](#-2-set-correct-power-bi-credentials)
      - [When prompted](#when-prompted)
  - [🧠 What the Dashboard Shows](#-what-the-dashboard-shows)
  - [🔄 Refreshing the Dashboard](#-refreshing-the-dashboard)
  - [🛠️ Troubleshooting](#️-troubleshooting)
  - [🧭 Need Help?](#-need-help)

This guide explains how to use the AI Hub Power BI dashboard to visualize usage, cost, and performance metrics based on data collected in CosmosDB.

> This is based on the official guide from the AI Hub Gateway repository.  
> 🔗 Reference Guide: https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator/blob/main/guides/power-bi-dashboard.md

---

## 📁 Dashboard File Location

The Power BI report `JDE-IT-AIHUB.pbix` has been copied into this repository for customization and internal use. Open the file using the Power BI Desktop application:

- File path in this repo: ../src/JDE-IT-AIHUB.pbix

You may also keep a canonical copy or variations outside the repo if your organization requires separate published artifacts.

---

## ⚠️ Prerequisites

Before opening or refreshing the report, ensure the following:

### ✅ 1. Your IP Can Access CosmosDB

The report queries CosmosDB directly. Ensure your public IP address is whitelisted in the CosmosDB firewall settings:

- Azure Portal → Your CosmosDB resource
- Networking → Firewall and virtual networks
- Add your current IP under Firewall rules and save

Alternatively, use corporate network connectivity methods (VPN, ExpressRoute) that allow access to the CosmosDB endpoint.

### ✅ 2. Set Correct Power BI Credentials

The dashboard requires credentials to query the CosmosDB account.

#### When prompted

- Authentication method: Choose "Azure Active Directory (Organizational Account)"
- Sign in with an account that has Reader / Data Reader access to the CosmosDB account (or an account configured by your team)
- For shared accounts, ensure they have at least read-only permissions to the correct DB and container

You can modify credentials anytime via:
Power BI Desktop → File → Options and settings → Data source settings

---

## 🧠 What the Dashboard Shows

Once connected, the dashboard provides:

- Model usage across endpoints
- Token usage (prompt, completion, total)
- Cost breakdowns by instance, deployment, and route
- User activity and RBAC-based filtering
- Trend lines and operational monitoring metrics

Use cases:

- Track usage trends over time
- Validate billing versus Azure consumption
- Audit user and model access patterns

---

## 🔄 Refreshing the Dashboard

To refresh data locally:

1. Open `JDE-IT-AIHUB.pbix` in Power BI Desktop
2. Ensure you're signed in with the correct Azure AD account
3. Click Home → Refresh
4. Inspect visuals and filters for expected results

Publishing to Power BI Service (optional):

- Publish the report to Power BI Service to enable scheduled refreshes and sharing
- If using Power BI Service with an on-premises/data gateway, configure gateway and credentials accordingly
- Scheduled refresh requires the service to have network access to CosmosDB (via firewall rules or private endpoints and gateway configuration)

---

## 🛠️ Troubleshooting

| Issue | Resolution |
|-------|------------|
| Access to resource is forbidden | Verify your IP is whitelisted in CosmosDB firewall and ensure your Azure AD account has required permissions. |
| Unable to connect to data source | Confirm CosmosDB endpoint, database and container names in the report queries have not changed. Validate network connectivity and credentials. |
| Data looks outdated | Manually trigger a refresh in Power BI Desktop or verify scheduled refresh in Power BI Service. Check CosmosDB ingestion and data pipeline health. |
| Authentication / token errors | Ensure the authentication method is set to Azure AD and the signed-in account has access. Re-enter credentials in Data source settings if needed. |

---

## 🧭 Need Help?

Refer to the official Power BI Dashboard Guide for the original background, data model expectations and advanced instructions:

- https://github.com/Azure-Samples/ai-hub-gateway-solution-accelerator/blob/main/guides/power-bi-dashboard.md

If the dashboard schema or data model changes:

- Re-align the `.pbix` file with the updated data model and relationships
- Update any queries referencing changed container/field names
- Consider regenerating or versioning the PBIX after larger schema changes

If you need assistance, open an issue in this repository or contact the maintainers.

---