export EDITOR="nvim"
export PATH=$HOME/bin:$HOME/.config/bin:$HOME/.config/bin/nvim-linux64/bin:$PATH
clear
random-quote
# task next limit:1

################################### oh-my-zsh specific ###################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dstufft"
ZSH_THEME_RANDOM_CANDIDATES=(
	"dstufft"
)
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
##########################################################################################


################################### zsh-plugins-manually loaded ###################################
source ~/.config/fzf-tab/fzf-tab.plugin.zsh
source ~/.config/zsh-plugins/zsh-autosuggestion/zsh-autosuggestions.zsh
source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
ZVM_VI_EDITOR=nvim
source ~/.config/zsh-plugins/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
##########################################################################################

alias z='zsh'
alias vw='nvim ~/notes/index.md -c "cd ~/notes"'
alias l='eza --icons -a'
alias ll='eza --icons -ahl'
alias cdd='. ~/.config/bin/cdd' # without . in front it wont change the directory
alias cddd='. ~/.config/bin/cddd' # without . in front it wont change the directory
alias dc='. ~/.config/bin/dc' # without . in front it wont change the directory
alias n="nvim ."
alias open='xdg-open'
alias openn='xdg-open "$(fzf)"'

# WSL only
if [ ! -z "$WSLENV" ] 
then
  alias vlc='vlc.exe'
  alias open='explorer.exe'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# taskwarrior 
alias t='task'
alias tg='task ghistory.weekly'

# pnpm
export PNPM_HOME="/home/volcano/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# GOlang
export PATH=$PATH:/usr/local/go/bin

# bun completions
[ -s "/home/volcano/.bun/_bun" ] && source "/home/volcano/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# doom emacs
export PATH="~/.config/emacs/bin:$PATH"

unsetopt BEEP # "no bell
