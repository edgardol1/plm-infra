data "google_project" "this" {}

resource "google_cloudfunctions2_function_iam_member" "cf_invoker" {
  project        = data.google_project.this.project_id
  location       = var.region
  cloud_function = "projects/${data.google_project.this.project_id}/locations/${var.region}/functions/${var.func_name}"
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${var.sa_email}"
}

resource "google_cloud_run_service_iam_member" "run_invoker" {
  project  = data.google_project.this.project_id
  location = var.region
  service  = "v1/projects/${data.google_project.this.project_id}/locations/${var.region}/services/${var.func_name}"
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.sa_email}"
}
