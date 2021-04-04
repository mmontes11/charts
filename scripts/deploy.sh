#!/bin/bash

set -e

echo "☸️  Loading manifests ..."
kubectl apply -f manifests/

echo "🚀 Deploying monitoring ..."
helm upgrade --install monitoring charts/monitoring -n monitoring

charts=(
  traefik
  duckdns
  github-explorer
  iot
  crypto-trade
  gotway
)
 
for chart in "${charts[@]}"
do
  echo "🚀 Deploying ${chart} ..."
  chart_path="charts/${chart}"
  helm upgrade --install "$chart" "$chart_path"
done