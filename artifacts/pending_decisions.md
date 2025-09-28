# Pending Decisions
- Rama default y protección.
- TF vars: project_id=leadgen-plm-prod-01, region=us-central1.
- Backend GCS: bucket=leadgen-plm-prod-01-tfstate, prefix=plm-infra/terraform.
- WIF: projects/62450699138/locations/global/workloadIdentityPools/gh-pool/providers/gh-provider2
- SA: tf-plan-bot@leadgen-plm-prod-01.iam.gserviceaccount.com
- Actions: plan/apply con WIF y tfvars seguros.
