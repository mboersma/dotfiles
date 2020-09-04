#!/bin/bash

set -euo pipefail

# Set kubectl context to KIND cluster
kind export kubeconfig --name kind-capz

# Export the first "-kubeconfig" secret found to "./capz-kubeconfig"
secret=$(kubectl get secret -A -o=custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | grep kubeconfig | head -1)
secret_array=(${secret})
namespace=${secret_array[0]}
name=${secret_array[1]}
filename=${name:0:${#name}-11}.conf
kubectl -n $namespace get secret/$name -o jsonpath={.data.value} | base64 --decode > $filename
echo "Wrote data from secret $namespace/$name to $filename."
