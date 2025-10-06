
package terraform

deny[msg] {

  some i

  input.resource_changes[i].type == "google_storage_bucket_iam_member"

  re_match("allUsers|allAuthenticatedUsers", input.resource_changes[i].change.after.member)

  msg := "GCS bucket IAM member allows public access"

}

