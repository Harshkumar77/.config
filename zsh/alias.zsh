
# Aliases
alias sl="ls"
alias la="ls -a"
alias ll="ls -la"
alias sread="speedread ~/active.txt -w 450"


alias gp="git push"
alias gc="git commit"
alias ga="git add"
alias gpl='git add .; git commit -m $(uuidgen); git push'

alias man='batman'

bookmarked_folders="~/.config
~"

if ! type "$(wsl.exe --version)" > /dev/null; then
  # echo wsl
  alias dmenu='/mnt/c/Program\ Files/wlines/wlines.exe | sed 's/.$//''

  # Browser
  alias firefox="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"

  win_username="$(cmd.exe /c echo %username% |  tr -d '\r' )"
  
  bookmarked_folders="${bookmarked_folders}
/mnt/c/Users/$win_username/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup
/mnt/c/notes/
/mnt/c/Users/$win_username/Downloads/
/mnt/c/Users/$win_username/Videos/"
fi
