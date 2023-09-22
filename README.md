# ai-chatbot-on-azure

## infra のデプロイ手順

```bash
export TF_VAR_AUTH_SECRET=...
export TF_VAR_AUTH_GITHUB_ID=...
export TF_VAR_AUTH_GITHUB_SECRET=...
export TF_VAR_NEXTAUTH_URL=https://ai-chatbot-on-azure-web-app.azurewebsites.net/

terraform init

terraform plan

terraform apply
```
