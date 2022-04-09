#!/bin/bash

set -e

# TODO: update default when deploying to production
HELM_REPO_URL="${HELM_REPO_URL:-https://charts.mmontes-dev-v2.duckdns.org}"
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

helm repo add mmontes $HELM_REPO_URL
source $CURRENT_DIR/scripts/common.sh
update_deps

for path in $(ls -d $CURRENT_DIR/charts/*); do
  name=$(basename "$path")
  echo "📦 Releasing '$name'..."
  helm cm-push "$path" mmontes
done
