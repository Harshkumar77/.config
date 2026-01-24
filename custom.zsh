export EDITOR='vim'

eval "$(zoxide init zsh)"   # For Zsh
alias cd='z'
alias l='fd --hidden --max-depth 1'

zi

# File Manager
echo -n "File Manager (y/n): "
read choice
choice=${choice:l}  # lowercase conversion
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    xdg-open "$(pwd)" 
    exit
elif [[ "$choice" == "n" || "$choice" == "no"  ]]; then
    thunar "$(pwd)" &
    echo "Opened $(pwd) in Thunar."
else
    echo "Cancelled."
fi

source ~/.config/alias.zsh




source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

bindkey '^R' fzf-history-widget

autoload -U compinit; compinit
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

# YUdGc2JHVnNkV0ZvQ2c9PQ==&aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2RyaXZlL3UvMC9mb2xkZXJzLzE4X29wUmt1WjluTk83SWY0blBFMmFRREdtMk5nLU1nSQ==&WVVkR2MySkhWbk5rVjBadlEyYzlQUT09
