
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
  mkdir ~/Music/Song/ -p
	cd ~/Music/Song
	pipx upgrade yt-dlp
	yt-dlp \
	  -x \
	  --audio-format mp3 \
	  --audio-quality 0 \
	  --embed-metadata \
	  --embed-thumbnail \
	  --convert-thumbnails jpg \
	  --add-metadata \
	  --sponsorblock-remove all \
	  --sleep-interval 5 --max-sleep-interval 10 \
    --download-archive archive.txt \
    "https://music.youtube.com/playlist?list=PLuDbTR3nQ_ZWl8j7gGxphy9vu9CL_ASSf"
  echo "#EXTM3U" > Song.m3u
  fd -e mp3 >> Song.m3u

  mkdir ~/Music/Long/ -p
	cd ~/Music/Long
	pipx upgrade yt-dlp
	yt-dlp \
	  -x \
	  --audio-format mp3 \
	  --audio-quality 0 \
	  --embed-metadata \
	  --embed-thumbnail \
	  --convert-thumbnails jpg \
	  --add-metadata \
	  --sponsorblock-remove all \
	  --sleep-interval 5 --max-sleep-interval 10 \
    --download-archive archive.txt \
    "https://youtube.com/playlist?list=PLuDbTR3nQ_ZUMRQGIydDRGe3lheNrPkYj&si=fC09ZYX__t0n10Tf"
  echo "#EXTM3U" > Long.m3u
  fd -e mp3 >> Long.m3u

  rm *.temp.*    

}

vlc-audio() {
	fd -e mp3 -X nohup vlc &
}

vlc-audio-shuffle() {
	fd -e mp3 -X nohup vlc --random &
}

mpv-audio() {
	fd -e mp3 -X nohup mpv &
}

mpv-audio-shuffle() {
	fd -e mp3 -X nohup mpv --shuffle &
}

mpv-video() {
	fd -e mkv -e mp4 -X nohup mpv &
}

mpv-video-shuffle() {
	fd -e mkv -e mp4 -X nohup mpv --shuffle &
}

vlc-video() {
	fd -e mkv -e mp4 -e mp3 -X nohup vlc &
}

vlc-video-shuffle() {
	fd -e mkv -e mp4 -e mp3 -X nohup vlc --random &
}

alias play-song='nohup vlc ~/Music/Song/Song.m3u --random &'
alias play-long='nohup vlc ~/Music/Long/Long.m3u --random &'



pdf() {
  cd ~/Electra Coil/
  fd --no-require-git -e pdf  --format "'{}'" | fzf -m | xargs  nohup okular {}
}
