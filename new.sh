echo "Make sure git is installed on the system .........."

rm ~/.config -rf

git clone --depth 1 https://github.com/Harshkumar77/.config.git ~/.config

ln ~/.config/home-dot-files/.vimrc ~/.vimrc
ln ~/.config/home-dot-files/.zshrc ~/.zshrc


echo "Make sure github-cli is installed"

echo https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2Flogin%2Fdevice
gh auth login
git config --global user.email "volcano@example.com"
git config --global user.name "volcano"
git clone https://github.com/Harshkumar77/personal-wiki.git --depth 1 ~/notes
chmod +x ~/notes/.task/hooks/on-modify.timewarrio
