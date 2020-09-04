#!/bin/bash

# Purges cached service principals

set -euo pipefail

for filename in ~/.azure/a?sServicePrincipal.json; do
  for sp in $(cat $filename | jq '.[].service_principal'); do
    echo "Deleting service principal $sp..."
    az ad sp delete --id $sp --verbose || true
  done
  rm $filename
done
