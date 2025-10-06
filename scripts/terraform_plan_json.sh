#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
./scripts/_require_tf.sh
: "${GOOGLE_APPLICATION_CREDENTIALS:?Debe exportarse GOOGLE_APPLICATION_CREDENTIALS}"

repo_root="$(pwd)"
mkdir -p "$repo_root/artifacts"

tfdir="terraform"
planfile="$repo_root/artifacts/tf.plan"
jsonfile="$repo_root/artifacts/tfplan.json"

terraform -chdir="$tfdir" init -reconfigure -no-color | tee "$repo_root/artifacts/init.log"
terraform -chdir="$tfdir" validate -no-color           | tee "$repo_root/artifacts/validate.log"
terraform -chdir="$tfdir" plan -no-color -out="$planfile" -var "project_id=leadgen-plm-prod-01" | tee "$repo_root/artifacts/plan.out.log"
terraform -chdir="$tfdir" show -json "$planfile" > "$jsonfile"

jq -r '
  reduce (.resource_changes[]? | .change.actions[]?) as $a
    ({add:0,change:0,destroy:0};
      .add     += (if $a=="create" then 1 else 0 end) |
      .change  += (if $a=="update" then 1 else 0 end) |
      .destroy += (if $a=="delete" then 1 else 0 end)
    )
' "$jsonfile" | tee "$repo_root/artifacts/plan.summary.json" || true
