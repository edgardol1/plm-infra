terraform {
  backend "gcs" {
    bucket = "leadgen-plm-prod-01-tfstate"
    prefix = "plm-infra/terraform"
  }
}
