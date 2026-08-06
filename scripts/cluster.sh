#!/usr/bin/env bash
# Manage the local kind cluster provisioned via Terraform.
# Usage: ./scripts/cluster.sh [up|down|recreate|status]
set -euo pipefail

TERRAFORM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../terraform" && pwd)"
ACTION="${1:-}"

cluster_up() {
  echo ">> Applying Terraform to create the kind cluster..."
  terraform -chdir="$TERRAFORM_DIR" init -input=false
  terraform -chdir="$TERRAFORM_DIR" apply -auto-approve
  echo ">> Cluster ready. Verifying with kubectl..."
  KUBECONFIG=$(terraform -chdir="$TERRAFORM_DIR" output -raw kubeconfig_path) kubectl cluster-info
}

cluster_down() {
  echo ">> Destroying the kind cluster via Terraform..."
  terraform -chdir="$TERRAFORM_DIR" destroy -auto-approve
}

cluster_status() {
  kind get clusters
  KUBECONFIG=$(terraform -chdir="$TERRAFORM_DIR" output -raw kubeconfig_path 2>/dev/null) kubectl get nodes -o wide 2>/dev/null || echo "Cluster not up."
}

case "$ACTION" in
  up)        cluster_up ;;
  down)      cluster_down ;;
  recreate)  cluster_down; cluster_up ;;
  status)    cluster_status ;;
  *)
    echo "Usage: $0 [up|down|recreate|status]"
    exit 1
    ;;
esac
