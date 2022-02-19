#!/bin/bash

set -e

helm plugin install https://github.com/chartmuseum/helm-push.git --version=v0.9.0
helm repo add mmontes https://charts.mmontes-dev.duckdns.org

source ./scripts/common.sh
update_deps

for path in $(ls -d charts/*); do
  name=$(basename "$path")
  echo "📦 Releasing '${name}'..."
  helm push "$path" mmontes
done
