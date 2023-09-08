msg="$(date | openssl shake128 | awk -F ' ' '{print $2}')"

echo "starting backup........."

echo '```' >> ~/notes/Tasklist.md
task list >> ~/notes/Tasklist.md
echo '```' >> ~/notes/Tasklist.md

git -C ~/.config add ~/.config/nvim
git -C ~/.config add ~/.config/wallpaper
git -C ~/.config add ~/.config/home-dot-files
git -C ~/.config add ~/.config/backup.sh
git -C ~/.config add ~/.config/bin 
git -C ~/.config add -u 
git -C ~/.config commit -m "$msg"
git -C ~/.config push
git -C ~/notes add -A
git -C ~/notes commit -m "$msg"
git -C ~/notes push

echo "backup done"
