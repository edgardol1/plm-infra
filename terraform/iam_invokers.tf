resource "google_cloudfunctions2_function_iam_member" "cf_invoker" {
  project        = var.project_id
  location       = var.region
  cloud_function = var.func_name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${var.sa_email}"
}

resource "google_cloud_run_service_iam_member" "run_invoker" {
  project  = var.project_id
  location = var.region
  service  = var.func_name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.sa_email}"
}
