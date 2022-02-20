#!/bin/bash

set -e

source ./scripts/common.sh
update_deps

echo "☸️  Creating namespaces..."
kubectl apply -f manifests/namespaces

echo "☸️  Creating secrets..."
kubectl apply -f manifests/secrets

echo "🚀 Deploying monitoring..."
helm upgrade monitoring charts/monitoring --install --wait --namespace monitoring

echo "🚀 Deploying traefik..."
helm upgrade traefik charts/traefik --install --namespace kube-system

echo "🚀 Deploying nfs provisioner..."
helm upgrade nfs charts/nfs-provisioner --install --namespace kube-system

echo "🚀 Deploying dns..."
helm upgrade duckdns charts/duckdns --install --namespace dns
helm upgrade pi-hole  charts/pi-hole --install --namespace dns

echo "🚀 Deploying chartmuseum..."
helm upgrade mmontes-charts charts/mmontes-charts --install --namespace chartmuseum

echo "🚀 Deploying media..."
helm upgrade mmontes-media  charts/mmontes-media --install --namespace media
helm upgrade xiaowen-media charts/xiaowen-media --install --namespace media

echo "🚀 Deploying iot..."
helm upgrade iot charts/iot --install --namespace iot

echo "🚀 Deploying github explorer..."
helm upgrade github-explorer charts/github-explorer --install --namespace github-explorer