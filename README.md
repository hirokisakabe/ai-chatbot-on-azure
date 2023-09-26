# ai-chatbot-on-azure

https://github.com/vercel-labs/ai-chatbot を Azure にデプロイしてみるサンプル

使っているサービスは以下の通り

- App Service
- Azure Container Registry
- Azure Cache for Redis

OpenAI は Azure AI services ではなく、OpenAI の API を直接使っている

## infra のデプロイ手順

```bash
export TF_VAR_NEXTAUTH_SECRET=...
export TF_VAR_AUTH_GITHUB_ID=...
export TF_VAR_AUTH_GITHUB_SECRET=...
export TF_VAR_NEXTAUTH_URL=https://ai-chatbot-on-azure-web-app.azurewebsites.net/
export TF_VAR_OPENAI_API_KEY=...

terraform init

terraform plan

terraform apply
```
