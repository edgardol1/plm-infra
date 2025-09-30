#!/usr/bin/env bash
set -euo pipefail
terraform -chdir=terraform fmt -check -recursive || true
terraform -chdir=terraform validate -no-color
