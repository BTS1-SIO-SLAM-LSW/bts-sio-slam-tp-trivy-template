#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-}"
if [[ -z "$IMAGE" ]]; then
  echo "Usage: $0 <image:tag>"
  exit 1
fi

mkdir -p reports
SAFE_NAME="${IMAGE//[:\/]/_}"

trivy image --severity HIGH,CRITICAL --format table "$IMAGE" > "reports/trivy_${SAFE_NAME}_table.txt"
trivy image --severity HIGH,CRITICAL --format json "$IMAGE" > "reports/trivy_${SAFE_NAME}.json"
trivy image --severity HIGH,CRITICAL --format sarif "$IMAGE" > "reports/trivy_${SAFE_NAME}.sarif"

ls -la reports
