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
}

errorWindow ()
{
  if [ ! -z "$WSLENV" ] 
  then
    alacritty.exe --hold -e "wsl.exe echo Error while backup"
  else
    alacritty --hold -e "echo Error while backup"
  fi
}

echo "starting backup........."
backup || errorWindow
echo "backup done"
