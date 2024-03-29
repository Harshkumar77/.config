msg="$(uuidgen)"

echo "starting backup........."

git -C ~/.config add ~/.config/nvim
git -C ~/.config add ~/.config/wallpaper
git -C ~/.config add ~/.config/home-dot-files
git -C ~/.config add ~/.config/backup.sh
git -C ~/.config add ~/.config/bin 
git -C ~/.config add ~/.config/go-sys-scipts
git -C ~/.config add ~/.config/cronjob
git -C ~/.config add ~/.config/nw.sh
git -C ~/.config add -u 
git -C ~/.config commit -m "$msg"
git -C ~/.config push

git -C ~/notes pull
git -C ~/notes add -A
git -C ~/notes commit -m "$msg"
git -C ~/notes push

crontab -l > ~/.config/cronjob

echo "backup done"
