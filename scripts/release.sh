#!/bin/bash

set -e

HELM_REPO_URL="${HELM_REPO_URL:-https://charts.mmontes-dev-v2.duckdns.org}"
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

helm plugin install https://github.com/chartmuseum/helm-push.git --version=v0.10.2
helm repo add mmontes $HELM_REPO_URL

source $CURRENT_DIR/scripts/common.sh
update_deps

for path in $(ls -d charts/*); do
  name=$(basename "$path")
  echo "📦 Releasing '${name}'..."
  helm cm-push "$path" mmontes
done
