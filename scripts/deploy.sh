#!/bin/bash

set -e

source ./scripts/common.sh
update_deps

echo "☸️  Loading manifests..."
kubectl apply -f manifests/

echo "🚀 Deploying monitoring..."
helm upgrade monitoring charts/monitoring --install --wait --namespace monitoring

charts=(
  traefik
  duckdns
  pi-hole
  github-explorer
  iot
  crypto-trade
  gotway
  mmontes-charts
  gotway-charts
)

for chart in "${charts[@]}"; do
  echo "🚀 Deploying '${chart}'..."
  chart_path="charts/${chart}"
  helm upgrade --install "$chart" "$chart_path"
done
