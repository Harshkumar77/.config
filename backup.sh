backup () {
  msg="$(uuidgen)"

  git -C ~/.config add ~/.config/nvim
  git -C ~/.config add ~/.config/wallpaper
  git -C ~/.config add ~/.config/home-dot-files
  git -C ~/.config add ~/.config/backup.sh
  git -C ~/.config add ~/.config/bin 
  git -C ~/.config add ~/.config/go-sys-scipts
  git -C ~/.config add ~/.config/cronjob
  git -C ~/.config add -u 
  git -C ~/.config commit -m "$msg"
  git -C ~/.config push

  git -C ~/notes pull
  git -C ~/notes add -A
  git -C ~/notes commit -m "$msg"
  git -C ~/notes push

  echo '```' > ~/notes/Tasklist.md
  task next >> ~/notes/Tasklist.md
  echo '```' >> ~/notes/Tasklist.md
  echo '```' >> ~/notes/Tasklist.md
  timew day >> ~/notes/Tasklist.md
  echo '```' >> ~/notes/Tasklist.md

  (cat $(fd --extension=md . ~/notes) | grep -Eo 'https?://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?') > ~/notes/more/urls_generated

}

errorWindow () {

  error_msg='Error while backup'
  if [ -z "$WSLENV" ] 
  then
    alacritty.exe --hold -e "wsl.exe echo $error_msg"
  else
    alacritty --hold -e "echo $error_msg"
  fi
}

echo "starting backup........."
backup || errorWindow
echo "backup done"
