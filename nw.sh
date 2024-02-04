# Initial
pacman -Syuu --noconfirm 

rm ~/.config -rf
git clone --depth 1 https://github.com/Harshkumar77/.config.git ~/.config
pacman -S vim zsh --noconfirm 

# yay for arch
pacman -S --needed --noconfirm git base-devel 

git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
cd /tmp/yay-bin 
makepkg -si --noconfirm 
yay --noconfirm 
cd ~

# Terminal - zsh tmux tmux kitty 
yay -S zsh eza fzf fd tmux kitty tmux curl xclip --noconfirm   
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc
ln -s ~/.config/home-dot-files/.zshrc ~
yay -S ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k  --noconfirm
yay -S lolcat --noconfirm

# vim
yay -S neovim unzip -noconfirm   
rm ~/.vimrc
ln -s ~/.config/home-dot-files/.vimrc ~

## c cpp
yay -S clang clangd  --noconfirm

## Javascript
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install --lts #Install the latest LTS version
nvm use --lts     #Use the latest LTS version
npm install -g pnpm

## go  
yay -S go --noconfirm

# Dev Tool
yay -S postman-bin  --noconfirm

# Necessary
yay -S librewolf-bin keepassxc task obsidian-bin syncthing --noconfirm

yay -S github-cli --noconfirm
echo https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2Flogin%2Fdevice
gh auth login
git config --global user.email "volcano@example.com"
git config --global user.name "volcano"
git clone https://github.com/Harshkumar77/personal-wiki.git --depth 1 ~/notes

crontab  ~/.config/cronjob

# Image to text
yay -S tesseract  tesseract-data-eng --noconfirm   

yay -S ytdlp  google-chrome  activitywatch-bin  variety dictd  qbittorrent  chromium  telegram-desktop-bin  mpv-sponsorblock  elisa  oh-my-zsh-git  --noconfirm

# gpu related
yay -S envycontrol --noconfirm

