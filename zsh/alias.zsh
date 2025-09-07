
# Aliases
if ! type "$eza" > /dev/null; then
  alias l='eza --icons'
  alias ls='eza'
  alias tree='eza --icons --tree'
  alias t='eza --icons --tree --level 1'
  alias t2='tree --level 2'
  alias t3='tree --level 3'
  alias t4='tree --level 4'
  alias t5='tree --level 5'
  alias t6='tree --level 6'
fi
alias sl="ls"
alias la="ls -a"
alias ll="ls -la"
alias sread="speedread ~/active.txt -w 450"


alias gp="git push"
alias gc="git commit"
alias ga="git add"
alias gpl='git add .; git commit -m $(uuidgen); git push'

alias man='batman'


bookmarked_folders="/home/brook/.config
/home/brook/"

if ! type "$(wsl.exe --version)" > /dev/null; then
  # echo wsl
  alias dmenu-w='/mnt/c/Program\ Files/wlines/wlines.exe | sed 's/.$//''
  alias dmenu='fzf -m --reverse'
  alias copyq="/mnt/c/Program\ Files/CopyQ/copyq.exe"
  # Browser
  alias firefox="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"
  alias ffmpeg="/mnt/c/Users/khars/AppData/Local/Microsoft/WinGet/Packages/**/bin/ffmpeg.exe"

  alias copy=' clip.exe'

  win_username="khars"
  # win_username="$(cmd.exe /c echo %username% |  tr -d '\r' )"

  alias alacritty='alacritty.exe'
  
  bookmarked_folders="${bookmarked_folders}
/mnt/c/Users/$win_username/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup
/mnt/c/notes/
/mnt/c/Users/$win_username/Downloads/
/mnt/c/Users/$win_username/Music/
/mnt/c/Users/$win_username/Videos/"
fi

alias cdd='dirto=$(echo "$bookmarked_folders" | xargs fd -t d . | dmenu);cd "$dirto"'
alias dc='dirto=$(fd -t d . | dmenu);cd "$dirto"'

alias nixInstall="home-manager switch"
alias nixInstallUpdate="sudo -i nix-channel --update;home-manager switch"
alias nixInstallUpdateFull="sudo nixos-rebuild switch;sudo -i nix-channel --update;home-manager switch"

alias rm="rm -rf"
alias cp="cp -rf"
