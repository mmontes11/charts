#!/bin/bash

set -e

helm plugin install https://github.com/chartmuseum/helm-push.git --version=v0.10.2
helm repo add --insecure-skip-tls-verify mmontes-v2 https://charts.mmontes-dev-v2.duckdns.org

source ./scripts/common.sh
update_deps

for path in $(ls -d charts/*); do
  name=$(basename "$path")
  echo "📦 Releasing '${name}'..."
  helm cm-push "$path" mmontes-v2
done
