#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
./scripts/_require_tf.sh
: "${GOOGLE_APPLICATION_CREDENTIALS:?Debe exportarse GOOGLE_APPLICATION_CREDENTIALS}"
mkdir -p artifacts
terraform -chdir=terraform init -reconfigure -no-color | tee artifacts/init.log
terraform -chdir=terraform validate -no-color           | tee artifacts/validate.log
terraform -chdir=terraform plan -no-color -var "project_id=leadgen-plm-prod-01" | tee artifacts/plan.log
