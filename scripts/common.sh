#!/bin/bash

function update_repos() {
  echo "☸️  Updating repos..."
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add chartmuseum https://chartmuseum.github.io/charts
  helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
  helm repo add liwenhe https://liwenhe1993.github.io/charts/
  helm repo add nats https://nats-io.github.io/k8s/helm/charts/
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo add traefik https://helm.traefik.io/traefik
  helm repo update
}
