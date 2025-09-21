# PLM Infra

## Requisitos locales
- gcloud autenticado al proyecto leadgen-plm-prod-01
- Terraform >= 1.5

## Uso rápido
cd terraform
terraform init
terraform apply -auto-approve

### Variables CI/CD (GitHub):
- `vars.GCP_PROJECT_ID`: leadgen-plm-prod-01
- `secrets.WIF_PROVIDER`: recurso Workload Identity Federation del repo
- `secrets.WIF_DEPLOY_SA`: SA con permisos para aplicar Terraform

## Dashboard
Usa la vista `leadgen-plm-prod-01.leads.vw_conversions` en Looker Studio y agrega métricas (count, sum(value)) y filtros por gclid/fecha.
