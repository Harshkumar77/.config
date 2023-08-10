echo "starting backup........."
git -C ~/.config add ~/.config/nvim
git -C ~/.config add -u 
git -C ~/.config commit -m "$(date)"
git -C ~/.config push
git -C ~/notes add -A
git commit -m "$(date)"
echo "backup done"
