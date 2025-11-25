# API Management Subscriptions

This landing zone provisions the following **subscriptions** in Azure API Management.  
Each subscription is automatically associated with a corresponding product and API specification.  

Developers can use their subscription keys to authenticate against the APIM gateway when accessing AIHub services.

## Subscriptions

| Subscription ID | Display Name                                                     | State   | Model-RBAC | Token-Limits | Allow Tracing |
|-----------------|------------------------------------------------------------------|---------|------------|--------------|---------------|
| genwizard       | GenWizard                                                        | active  | false      | 128K         | false         |
| hcl-aex         | AEX - GenAI cognitive chatbot Technology Services (Mocha-QA)     | active  | false      | 500K         | false         |
| chatbot         | MSFT chatbot                                                     | active  | false      | default      | false         |
| nextgen         | nextgen                                                          | active  | false      | default      | false         |
| hcl-aex-prd     | AEX - GenAI cognitive chatbot Technology Services (Mocha-PRD)    | active  | false      | 500K         | true          |

> **Note:** The default Token-Limits correspond to **50,000 TPM** (tokens per minute).  

---
