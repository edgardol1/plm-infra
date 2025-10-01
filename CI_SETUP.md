# CI Setup

Para que los workflows de Terraform funcionen con Workload Identity Federation (WIF), crear estos Secrets en GitHub:

- **GCP_PROJECT_ID** → ID del proyecto (ej: `leadgen-plm-prod-01`)
- **GCP_WIF_PROVIDER** → nombre completo del proveedor WIF  
  (`projects/62450699138/locations/global/workloadIdentityPools/gh-pool/providers/gh-provider2`)
- **GCP_WIF_SA** → Service Account que usará WIF  
  (`tf-plan-bot@leadgen-plm-prod-01.iam.gserviceaccount.com`)

## Flujo de trabajo
- **Pull Request (PR)** → ejecuta `plan.yaml` para validar y generar un plan.  
- **Merge a main** → ejecuta `apply.yaml` para aplicar los cambios.  
