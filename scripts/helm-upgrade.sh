#!/usr/bin/env bash
# Upgrade (or install, if not present) the microservices Helm release.
# Usage: ./scripts/helm-upgrade.sh [namespace] [release-name]
set -euo pipefail

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../helm/microservices" && pwd)"
NAMESPACE="${1:-microservices-demo}"
RELEASE="${2:-microservices-demo}"

echo ">> Linting chart..."
helm lint "$CHART_DIR"

echo ">> Upgrading (or installing) release '$RELEASE' in namespace '$NAMESPACE'..."
helm upgrade --install "$RELEASE" "$CHART_DIR" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --wait \
  --timeout 2m

echo ">> Release status:"
helm status "$RELEASE" -n "$NAMESPACE"

echo ">> Rollout verification:"
kubectl rollout status deployment/frontend -n "$NAMESPACE"
kubectl rollout status deployment/backend -n "$NAMESPACE"

echo ">> Revision history:"
helm history "$RELEASE" -n "$NAMESPACE"
