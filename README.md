# ai-chatbot-on-azure

https://github.com/vercel-labs/ai-chatbot を Azure にデプロイしてみるサンプル

使っているサービスは以下の通り

- App Service
- Azure Container Registry
- Azure Cache for Redis

OpenAI は Azure AI services ではなく、OpenAI の API を直接使っている

## app のデプロイ手順

```bash
az login

az acr login -n aichatbotonazureregistry

docker build . -t aichatbotonazureregistry.azurecr.io/samples/ai-chatbot-on-azure:latest

docker push aichatbotonazureregistry.azurecr.io/samples/ai-chatbot-on-azure:latest
```

## infra のデプロイ手順

```bash
# 事前に terraform.tfvars.example を terraform.tfvars にコピーして、値を設定する

terraform init

terraform plan -var-file=terraform.tfvars

terraform apply -var-file=terraform.tfvars
```
