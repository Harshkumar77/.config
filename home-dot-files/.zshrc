export PATH=$HOME/.config/bin:$HOME/.config/bin/nvim-linux64/bin:$PATH
random-quote

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dstufft"
ZSH_THEME_RANDOM_CANDIDATES=(
	"dstufft"
)

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh
# "no bell
unsetopt BEEP

source ~/.config/fzf-tab/fzf-tab.plugin.zsh
source ~/.config/zsh-plugins/zsh-autosuggestion/zsh-autosuggestions.zsh
source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
ZVM_VI_EDITOR=nvim
source ~/.config/zsh-plugins/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

alias vw='nvim ~/notes/index.md'
# alias tx='tmux attach || tmux new-session -s "default"'
alias l='exa --icons -a'
alias ll='exa --icons -ahl'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
