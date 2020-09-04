# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Personal configuration
export CLICOLOR=1

# load sensitive environment variables from a file not in version control
if [ -f $HOME/.environment ]; then
    source $HOME/.environment
fi

# aks-engine and CAPZ
if [ -f $HOME/.ssh/akse.pub ]; then
    export AKSE_PUB_KEY=$(cat $HOME/.ssh/akse.pub)
fi
alias akse-locs='./bin/aks-engine get-locations --client-id=${AZURE_CLIENT_ID} --client-secret=${AZURE_CLIENT_SECRET} --subscription-id=${AZURE_SUBSCRIPTION_ID}'
alias akse-skus='./bin/aks-engine get-skus --client-id=${AZURE_CLIENT_ID} --client-secret=${AZURE_CLIENT_SECRET} --subscription-id=${AZURE_SUBSCRIPTION_ID}'
alias akse-deploy='./bin/aks-engine deploy --debug --dns-prefix maboersm -f -m ./examples/kubernetes.json -l eastus --client-id=${AZURE_CLIENT_ID} --client-secret=${AZURE_CLIENT_SECRET} --set linuxProfile.ssh.publicKeys\[0\].keyData="${AKSE_PUB_KEY}" --set orchestratorProfile.orchestratorRelease=1.19'
alias akse-e2e='CLUSTER_DEFINITION=./examples/kubernetes.json CLEANUP_ON_EXIT=false LOCATION=eastus GINKGO_FOCUS="should have addons running" make build test-kubernetes'
alias akse-e2e2='ORCHESTRATOR_RELEASE=1.19 CLUSTER_DEFINITION=examples/e2e-tests/kubernetes/release/default/definition.json SKIP_LOGS_COLLECTION=true CLEANUP_ON_EXIT=false CLEANUP_IF_FAIL=false CREATE_VNET=true STABILITY_ITERATIONS=3 SKIP_TEST=false make test-kubernetes'
alias akse-cmd-cov='go test -coverprofile cover.out github.com/Azure/aks-engine/cmd && go tool cover -html=cover.out -o cover.html && ecopen cover.html'
alias akse-ssh='ssh -i ~/.ssh/akse -o StrictHostKeyChecking=no azureuser@maboersm.eastus.cloudapp.azure.com'
alias capz-kconfigs='kubectl get secret -A -o=custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | grep kubeconfig'
# export KUBECONFIG=$HOME/Projects/aks-engine/_output/maboersm/kubeconfig/kubeconfig.eastus.json

# Configuration for macOS workstation only
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Python
  export PATH="/usr/local/opt/python@3.8/bin:$PATH"
  # Go
  export GOPATH=$HOME/Projects
  export PATH=$PATH:$GOPATH/bin
#   export GOENV_ROOT=$HOME/.goenv
#   export PATH=$PATH:$GOENV_ROOT/bin
#   eval "$(goenv init -)"
#   export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
  # Rust
  export PATH="$PATH:$HOME/.cargo/bin"
  # Microsoft
  alias idweb='kinit maboersm@NORTHAMERICA.CORP.MICROSOFT.COM && open -a safari https://idweb/'
fi
