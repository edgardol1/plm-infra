#!/usr/bin/env bash
set -euo pipefail
req="1.13.3"
have="$(terraform version | awk 'NR==1{print $2}' | tr -d 'v')"
[ "$have" = "$req" ] || { echo "ERROR: Terraform v$req requerido, encontrado v$have" >&2; exit 1; }
