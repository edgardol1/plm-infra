terraform {
  required_version = ">= 1.5.0"
  required_providers { google = { source = "hashicorp/google", version = "~> 5.30" } }
}
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "caller" {
  account_id   = var.sa_caller
  display_name = "CF Caller"
}

# Invoker en CF Gen2 (solo SA)
resource "google_cloudfunctions2_function_iam_member" "cf_invoker" {
  project        = var.project_id
  location       = var.region
  cloud_function = var.func_name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${google_service_account.caller.email}"
}

# Invoker en Cloud Run subyacente (mismo nombre que la CF)
resource "google_cloud_run_service_iam_member" "run_invoker" {
  project  = var.project_id
  location = var.region
  service  = var.func_name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.caller.email}"
}

# Impersonación para tu usuario
resource "google_service_account_iam_member" "caller_token_creator" {
  service_account_id = google_service_account.caller.name
  role   = "roles/iam.serviceAccountTokenCreator"
  member = "user:${var.ci_user_email}"
}
resource "google_service_account_iam_member" "caller_user" {
  service_account_id = google_service_account.caller.name
  role   = "roles/iam.serviceAccountUser"
  member = "user:${var.ci_user_email}"
}

# Dataset y vista de panel
resource "google_bigquery_dataset" "leads" {
  dataset_id = var.bq_dataset
}
resource "google_bigquery_table" "vw_conversions" {
  dataset_id = google_bigquery_dataset.leads.dataset_id
  table_id   = "vw_conversions"
  view {
    query = <<EOT
SELECT order_id, gclid, value, currency, ingested_at
FROM \`${var.project_id}.${var.bq_dataset}.${var.bq_table}\`
ORDER BY ingested_at DESC
EOT
    use_legacy_sql = false
  }
}
