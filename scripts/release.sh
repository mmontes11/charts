#!/bin/bash

set -e

helm plugin install https://github.com/chartmuseum/helm-push.git
helm repo add mmontes https://charts.mmontes-dev.duckdns.org

source ./scripts/common.sh
update_repos

for path in $(ls -d charts/*); do
    name=$(basename "$path")
    echo "📦 Releasing '${name}'..."
    helm push "$path" mmontes
done
