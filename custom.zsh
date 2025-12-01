export EDITOR='vim'

eval "$(zoxide init zsh)"   # For Zsh
alias cd='z'
alias l='fd --hidden --max-depth 1'

zi

# File Manager
echo -n "File Manager (y/n): "
read choice
choice=${choice:l}  # lowercase conversion
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    thunar "$(pwd)" &
    echo "Opened $(pwd) in Thunar."
else
    echo "Cancelled."
fi


rmf() {
	fzf -m --header="Select files to delete" | while IFS= read -r file; do
	    rm -- "$file"
	done
}

alias awesome-launch="killall xfwm4 && awesome"
alias xfce-launch="killall awesome && xfwm4"


vlc-random(){
	OUT="/tmp/vlc-$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8).m3u"
	fd . -e mkv -a | shuf > "$OUT"
	nohup vlc "$OUT" >/dev/null 2>&1 &
}

stream-mpv(){
	url=$(zenity --entry --title="url")
	url=$(yt-dlp --get-url "$(url)") 
	nohup mpv "$(url)" 
}
alias extract-urls='xidel -e "//a/@href'
alias copy-file='xclip -selection clipboard < '
