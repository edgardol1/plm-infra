terraform {
  required_version = ">= 1.5.0"
  required_providers { google = { source = "hashicorp/google", version = "~> 5.30" } }
}
provider "google" {
  project = var.project_id
  region  = var.region
}

# Invoker en CF Gen2 (solo SA existente)
resource "google_cloudfunctions2_function_iam_member" "cf_invoker" {
  project        = var.project_id
  location       = var.region
  cloud_function = var.func_name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${var.sa_email}"
}

# Invoker en Cloud Run subyacente (mismo nombre que la CF)
resource "google_cloud_run_service_iam_member" "run_invoker" {
  project  = var.project_id
  location = var.region
  service  = var.func_name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.sa_email}"
}
