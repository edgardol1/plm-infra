package terraform
allowlist := {"us-central1","us-east1"}
deny[msg] {
  some i
  rc := input.resource_changes[i]
  rc.change.after.location != null
  not allowlist[rc.change.after.location]
  msg := sprintf("Region/location not allowed: %v", [rc.change.after.location])
}
