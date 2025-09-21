data "google_project" "this" {
  project_id = var.project_id
}

output "project_number" {
  value = data.google_project.this.number
}
