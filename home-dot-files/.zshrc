if [[ ! $(tmux list-sessions) ]]; then 
  ~/.config/bin/tx
fi


export EDITOR="nvim"
export PATH=$HOME/go/bin:$HOME/bin:$HOME/.config/bin:$PATH
# timew day
random-quote
# task next limit:1

################################### oh-my-zsh specific ###################################
# export ZSH="$HOME/.oh-my-zsh"
# export ZSH=/usr/share/oh-my-zsh/
export ZSH=$HOME/.nix-profile/share/oh-my-zsh

ZSH_THEME="dstufft"
ZSH_THEME_RANDOM_CANDIDATES=(
	"dstufft"
)
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git npm gh)
source $ZSH/oh-my-zsh.sh
##########################################################################################


################################### zsh-plugins-manually loaded ###################################
# source ~/.config/fzf-tab/fzf-tab.plugin.zsh
# # tabtab source for packages
# # uninstall by removing these lines
# # I have no idea how I make it work don't delete it
# [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons -a --color=always $realpath'
zstyle ':completion:*:git-checkout:*' sort false
source ~/.nix-profile/share/fzf-tab/fzf-tab.plugin.zsh

# source ~/.config/zsh-plugins/zsh-autosuggestion/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.nix-profile/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh

ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
ZVM_VI_EDITOR=nvim
# source ~/.config/zsh-plugins/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.nix-profile/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
##########################################################################################

alias z='zsh'
alias vw='tmux rename-window "notes"; nvim ~/notes/diary/diary.md -c "VimwikiDiaryGenerateLinks" -c "VimwikiMakeYesterdayDiaryNote" -c "VimwikiMakeDiaryNote" -c "e ~/notes/index.md" -c "cd ~/notes" -c "GlassToggle" -c "LspStop"'
alias l='eza --icons -a'
alias ll='eza --icons -ahl'
alias lt='tree --si -I "node_modules" -I ".git" -a -n'
alias bat='bat --theme="Monokai Extended Origin"'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias cdd='. ~/.config/bin/cdd' # without . in front it wont change the directory
alias cddd='. ~/.config/bin/cddd' # without . in front it wont change the directory
alias dc='. ~/.config/bin/dc' # without . in front it wont change the directory
alias n="nvim ."
alias open='xdg-open 2>/dev/null'
alias openn='xdg-open 2>/dev/null "$(fzf)"'
alias quote='xdg-open "https://duckduckgo.com/?q=$(cat /tmp/qt434341)"'

alias pwc='pwd | xclip -selection clipboard; echo copied $PWD' # copy pwd
alias xlast="LAST_COMMAND_EXECUTED_IN_ZSH=\`tac ~/.zsh_history | head -n 2 | tail -n 1 | awk -F';'  '{print \$2}'\`;
	      printf \$LAST_COMMAND_EXECUTED_IN_ZSH | xclip -selection clipboard  ; echo \$LAST_COMMAND_EXECUTED_IN_ZSH" # copy last executed cmd and prints to terminal
alias revise='bat $(fd --extension=md .  ~/notes/dev/Leetcode  ~/notes/Helpful-knowlege/ -E "Leetcode*" | shuf)'


# screenshot to text
alias w='tesseract -l eng "$HOME/Pictures/$(ls $HOME/Pictures -t | head -1)" /tmp/output_from_ocr && cat /tmp/output_from_ocr.txt && cat /tmp/output_from_ocr.txt | xclip -selection clipboard'

# WSL only
if [ -z "$WSLENV" ] 
then
  alias vlc='vlc.exe'
  alias open='wslview'
  alias xdg-open='wslview'
  alias openn='wslview "$(fzf)"'
  alias shutdown='wsl.exe --shutdown'
  alias winget='winget.exe'
  alias wsl='wsl.exe'

  config-sync-wsl () {
    win_username="$(cmd.exe /c echo %username% |  tr -d '\r' )"

    # Alacritty
    cp "$HOME/.config/alacritty/alacritty.toml" "/mnt/c/Users/$win_username/AppData/Roaming/alacritty"
    cp "$HOME/.config/wallpaper" "/mnt/c/Users/$win_username/OneDrive/Pictures" -r &
  }

fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# taskwarrior 
alias t='task'
alias tg='task ghistory.weekly && timew week'
alias tcal='task calendar'
alias tstart='go run ~/.config/go-sys-scipts/taskwarrior-start.go'
alias tstop='task +ACTIVE stop'
alias tdone='t +ACTIVE done'
alias ttoggle=' task +ACTIVE stop || go run ~/.config/go-sys-scipts/taskwarrior-start.go'
alias torg='t oldest -TAGGED'
alias t1='task minimal limit:1'
alias t2='task minimal limit:2'
alias t3='task minimal limit:3'
alias t4='task minimal limit:4'
alias t5='task minimal limit:5'
alias t6='task minimal limit:6'
alias t7='task minimal limit:7'
alias t8='task minimal limit:8'
alias t9='task minimal limit:9'
alias t10='task minimal limit:10'
alias T1='task next limit:1'
alias T2='task next limit:2'
alias T3='task next limit:3'
alias T4='task next limit:4'
alias T5='task next limit:5'
alias T6='task next limit:6'
alias T7='task next limit:7'
alias T8='task next limit:8'
alias T9='task next limit:9'
alias T10='task next limit:10'
alias tsum='task summary'
alias tm='timew'
alias tw='timew'
alias taskwarrior-garbage-collection='task rc.gc=on list'

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# GOlang
export PATH=$PATH:/usr/local/go/bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

unsetopt BEEP # "no bell

# Silently run a command
silent () {
   $1 &>/dev/null &
}

# DB related shit
alias pg_start='~/.config/DB/pg_start.sh'
alias dbeaver='silent dbeaver'
alias pg_admin='silent pgadmin4'

# Git related
alias gl="git log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full"


# eval "$(rbenv init - zsh)"
# export GEM_HOME=~/.gem/

# NIX only
if [ ! -z "$NIX_PROFILES" ] 
then
  source ~/.nix-profile/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh
  fpath=(~/.nix-profile/share/zsh/plugins/nix/nix-zsh-completions $fpath)
  autoload -U compinit && compinit
fi
