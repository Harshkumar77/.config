echo "starting backup........."
git add ~/.config/nvim
git commit -m "$(date)"
git push
echo "backup done"
