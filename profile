# Personal configuration
export CLICOLOR=1
export PATH=$PATH:/Users/matt/bin

# Start the GNUPG agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  eval $(gpg-agent --daemon)
fi

# Python
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

# Go
export GOPATH=$HOME/Projects
export GOENV_ROOT=$HOME/.goenv
export PATH=$PATH:$GOENV_ROOT/bin
eval "$(goenv init -)"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# TODO: load secrets from a file not in version control

# aks-engine and CAPZ
export AKSE_PUB_KEY=$(cat $HOME/.ssh/akse.pub)
alias akse-locs='./bin/aks-engine get-locations --client-id=${AZURE_CLIENT_ID} --client-secret=${AZURE_CLIENT_SECRET} --subscription-id=${AZURE_SUBSCRIPTION_ID}'
alias akse-skus='./bin/aks-engine get-skus --client-id=${AZURE_CLIENT_ID} --client-secret=${AZURE_CLIENT_SECRET} --subscription-id=${AZURE_SUBSCRIPTION_ID}'
alias akse-deploy='./bin/aks-engine deploy --debug --dns-prefix maboersm -f -m ./examples/kubernetes.json -l eastus --client-id=${AZURE_CLIENT_ID} --client-secret=${AZURE_CLIENT_SECRET} --set linuxProfile.ssh.publicKeys\[0\].keyData="${AKSE_PUB_KEY}" --set orchestratorProfile.orchestratorRelease=1.19'
alias akse-e2e='CLUSTER_DEFINITION=./examples/kubernetes.json CLEANUP_ON_EXIT=false LOCATION=eastus GINKGO_FOCUS="should have addons running" make build test-kubernetes'
alias akse-e2e2='ORCHESTRATOR_RELEASE=1.19 CLUSTER_DEFINITION=examples/e2e-tests/kubernetes/release/default/definition.json SKIP_LOGS_COLLECTION=true CLEANUP_ON_EXIT=false CLEANUP_IF_FAIL=false CREATE_VNET=true STABILITY_ITERATIONS=3 SKIP_TEST=false make test-kubernetes'
alias akse-cmd-cov='go test -coverprofile cover.out github.com/Azure/aks-engine/cmd && go tool cover -html=cover.out -o cover.html && open cover.html'
alias akse-ssh='ssh -i ~/.ssh/akse -o StrictHostKeyChecking=no azureuser@maboersm.eastus.cloudapp.azure.com'
export KUBECONFIG=$HOME/Projects/aks-engine/_output/maboersm/kubeconfig/kubeconfig.eastus.json

# Microsoft stuff
alias idweb='kinit maboersm@NORTHAMERICA.CORP.MICROSOFT.COM && open -a safari https://idweb/'
