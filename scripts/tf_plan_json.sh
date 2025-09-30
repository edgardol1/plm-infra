#!/usr/bin/env bash
set -euo pipefail

mkdir -p artifacts

terraform -chdir=terraform plan -no-color -out=artifacts/tf.plan

terraform show -json artifacts/tf.plan > artifacts/tfplan.json

jq '{
  add: .resource_changes | map(select(.change.actions | index("create"))) | length,
  change: .resource_changes | map(select(.change.actions | index("update"))) | length,
  destroy: .resource_changes | map(select(.change.actions | index("delete"))) | length
}' artifacts/tfplan.json > artifacts/plan.summary.json
