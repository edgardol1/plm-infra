
package terraform

deny[msg] {

  some i

  input.resource_changes[i].type == "google_project_iam_member"

  endswith(input.resource_changes[i].change.after.role, "admin")

  msg := sprintf("Project IAM admin role not allowed: %v", [input.resource_changes[i].change.after.role])

}

