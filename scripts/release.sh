#!/bin/bash

set -e

HELM_REPO_URL="${HELM_REPO_URL:-https://charts.mmontes.duckdns.org}"
CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")

echo "☸️  Starting helm chart release for '$HELM_REPO_URL' repository"

echo "☸️  Updating repos..."
helm repo add mmontes $HELM_REPO_URL
helm repo add liwenhe https://liwenhe1993.github.io/charts/
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo update

echo "☸️  Updating dependencies..."
helm dep update "charts/crypto-trade"

for path in $(ls -d $CURRENT_DIR/../charts/*); do
  name=$(basename "$path")
  echo "📦 Releasing '$name'..."
  helm cm-push "$path" mmontes
done
