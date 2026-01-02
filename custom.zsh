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
    thunar "$(pwd)" &
    echo "Opened $(pwd) in Thunar."
else
    echo "Cancelled."
fi

source ~/.config/alias.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
bindkey '^R' fzf-history-widget

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
