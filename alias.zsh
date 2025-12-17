
rmf() {
        fd --maxdepth 1 | fzf -m --header="Select files to delete" | while IFS= read -r file; do
            rm -rf -- "$file"
        done
}

alias awesome-launch="killall xfwm4 && awesome"
alias xfce-launch="killall awesome && xfwm4"

alias vlc='nohup vlc'
alias mpv='nohup mpv'

alias extract-urls='xidel -e "//a/@href'
alias copy-file='xclip -selection clipboard < '

alias wallpaper='sxiv ~/.config/wallpaper -qbf -s f -S 3'

download-songs() {
	cd ~/Music
	pipx upgrade yt-dlp
	yt-dlp --download-archive archive.txt --no-overwrites "https://www.youtube.com/playlist?list=PLuDbTR3nQ_ZV5KbLw1w-s1Tmhq0g--4S7" -t mp3 --embed-metadata --embed-thumbnail --sponsorblock-remove all   --write-subs --embed-subs  --sleep-interval 5 --max-sleep-interval 10
#	mkdir temp 
#	mv *.mp3 archive.txt temp  
#	fd -t f --maxdepth 1 --exec rm   
#	mv temp/* .  
#	rmdir temp  
	rm *.temp.*    

}

vlc-audio() {
	fd -e mp3 -X nohup vlc &
}

vlc-audio-shuffle() {
	fd -e mp3 -X nohup vlc --random &
}

celluloid-audio() {
	fd -e mp3 -X nohup celluloid &
}

celluloid-audio-shuffle() {
	fd -e mp3 -X nohup celluloid --shuffle &
}

mpv-video() {
	fd -e mkv -e mp4 -X nohup mpv &
}

mpv-video-shuffle() {
	fd -e mkv -e mp4 -X nohup mpv --shuffle &
}

vlc-video() {
	fd -e mkv -e mp4 -X nohup vlc &
}

vlc-video-shuffle() {
	fd -e mkv -e mp4 -X nohup vlc --random &
}
