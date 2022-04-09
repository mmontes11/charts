#!/bin/bash

set -e

# TODO: update default when deploying to production
HELM_REPO_URL="${HELM_REPO_URL:-https://charts.mmontes-dev-v2.duckdns.org}"
CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")

echo "☸️  Starting helm chart release for '$HELM_REPO_URL' repository"

echo "☸️  Updating repos..."
helm repo add mmontes $HELM_REPO_URL
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add chartmuseum https://chartmuseum.github.io/charts
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo add liwenhe https://liwenhe1993.github.io/charts/
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add traefik https://helm.traefik.io/traefik
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update

for path in $(ls -d $CURRENT_DIR/../charts/*); do
  name=$(basename "$path")
  echo "📦 Releasing '$name'..."
  helm dep update "$path"
  helm cm-push "$path" mmontes
done
