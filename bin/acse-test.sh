#!/bin/sh

set -euo pipefail

ACSE_DIR=$GOPATH/src/github.com/Azure/acs-engine
RG=${RG:-maboersm}

cd "$ACSE_DIR"

make build
acs-engine generate --api-model pkg/acsengine/testdata/simple/kubernetes.json
az group deployment validate -g "$RG" --parameters _output/masterdns1/azuredeploy.parameters.json --template-file _output/masterdns1/azuredeploy.json

cd -
