#!/bin/bash

set -e

source ./scripts/common.sh
update_repos

for ch in $(ls -d charts/*); do
  echo "☸️  Updating '$ch' deps..."
  helm dep update $ch
done