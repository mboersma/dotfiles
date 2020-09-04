# bash configuration on macOS for Matt Boersma

[[ -r "$HOME/.profile" ]] && source $HOME/.profile

# Bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# AKS Engine completion
eval "$(aks-engine completion)"
