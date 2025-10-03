#!/usr/bin/env bash
set -euo pipefail
FILE="artifacts/pending_decisions.md"
ts="$(date -Is)"
if [[ ! -f "$FILE" ]]; then
  cat > "$FILE" <<EOF
# Pending Decisions
- ${ts} · Inicializado por CI.
EOF
else
  echo "- ${ts} · CI heartbeat." >> "$FILE"
fi
git config user.name "ci-bot"
git config user.email "ci-bot@users.noreply.github.com"
git add "$FILE"
git commit -m "ci: update pending_decisions.md" || true
