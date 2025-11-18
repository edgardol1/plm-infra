package terraform
required := {"env","owner","cost_center"}
deny[msg] {
  some i
  rc := input.resource_changes[i]
  rc.change.after.tags == null
  msg := sprintf("Resource %v missing tags", [rc.address])
}
