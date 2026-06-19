#!/usr/bin/env bash
set -euo pipefail

if [ -d ".venv" ]; then
  # shellcheck source=/dev/null
  source .venv/bin/activate
fi

for ENVIRONMENT in QA1 QA2 QA3; do
  echo "Running web tests for ${ENVIRONMENT}"
  robot -d "results/web/${ENVIRONMENT}" -v ENV:"${ENVIRONMENT}" tests/web

done
