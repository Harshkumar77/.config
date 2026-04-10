rmf() {
    fd --maxdepth 1 | rofi -dmenu -multi-select -p "Select files to delete" | while IFS= read -r file; do
        rm -rf -- "$file"
    done
}

archive() {
  zsh -c "~/archive/create-backup.sh"
}

alias awesome-launch="killall xfwm4 && awesome"
alias xfce-launch="killall awesome && xfwm4"

alias vlc='nohup vlc'
alias mpv='nohup mpv'
alias bmpv='/bin/mpv'


# alias extract-urls() {
#   curl $1 | xidel -e "//a/@href"'
# }

alias copy-file='xclip -selection clipboard < '

alias wallpaper='sxiv ~/.config/wallpaper -qbf -s f -S 3'

alias cdd='zi'

download-songs() {
    zsh -c "$(node ~/.config/scripts/download-songs.ts)"
    node ~/.config/scripts/conan.ts
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
    file_name=$(uuidgen)
    (fd -e mkv -e mp4 -e mp3 -e mkv.part -e mp3.part -e mp4.part) > playlist.m3u
    xdg-open playlist.m3u
    sleep 3
    rm playlist.m3u
    exit
}

anime-latest() {
    file_name=$(uuidgen)
    cd ~/Downloads/Organised\ Episodes
    (fd -e mkv -e mp4 -X ls -t) > playlist.m3u
    xdg-open playlist.m3u
    sleep 3
    rm playlist.m3u
    exit
}

yt() {
    pipx upgrade yt-dlp
    latest_url=$(copyq eval -- "tab('clipboard'); for(i=size(); i>0; --i) print(str(read(i-1)) + '\n');" | rg youtube | tail -1)
    nohup mpv "$latest_url" --pause
}

mpv-video-shuffle() {
    fd -e mkv -e mp4 -X nohup mpv --shuffle &
}

vlc-video() {
    file_name=$(uuidgen)
    fd -e mkv -e mp4 -a > /tmp/$file_name.m3u
    nohup vlc /tmp/$file_name.m3u
}

vlc-video-shuffle() {
    fd -e mkv -e mp4 -e mp3 -X nohup vlc --random &
}

alias play-long-on-start='mpv ~/Music/Long/Long.m3u --pause --loop-playlist=yes --shuffle --no-save-position-on-quit'
alias play-song-on-start='mpv ~/Music/Song/Song.m3u --pause --loop-playlist=yes --shuffle --no-save-position-on-quit'

play() {
    p=$(fd . ~/Music -e m3u)
    pp=$(node -p "
      \`$p\`
        .split('\n')
        .map(y => y.split('/').pop().split('.')[0])
        .join('\n')
      " | rofi -dmenu)
    ppp=$(fd . ~/Music -e m3u --and "$pp" | head -1)
    nohup mpv "$ppp" --pause --loop-playlist=yes --shuffle --no-save-position-on-quit  >/dev/null 2>&1 &
}


pdf() {
    p=$(fd . "$HOME/Electra Coil/" -e pdf -x echo '{/.}' | rofi -dmenu -multi-select)
    search_str=$(node -p "
      \`$p\`.split('\n').join('|')
    ")
    fd . "$HOME/Electra Coil/" -e pdf --and "$search_str" | xargs -I{} thunar '{}' &
}

twall() {
    wallpaper_selected="$(fd . --absolute-path ~/.config/wallpaper | shuf | tail -1)"
    tiv -w $(($COLUMNS*2)) "$wallpaper_selected"
}

twallz() {
    wallpaper_selected="$(fd . --absolute-path ~/.config/wallpaper | shuf | tail -1)"
    tiv -w $(($COLUMNS)) "$wallpaper_selected"
}

games() {
    opts=$(node -p '[
        "yetris",
        "2048-tui",
        "snake",
        "myman",
    ]
      .map((x) => {
        return `alacritty --command "${x}"`
      })
      .join("\n") + "\n" + [
        "https://poki.com/en/g/temple-run-2",
        "https://poki.com/en/g/harvest-simulator",
        "https://poki.com/en/g/subway-surfers",
        "https://poki.com/en/g/neon-challenge-legends",
        "https://quenq.com/apps/vice-city/",
    ]
      .map((x) => {
        return `firefox-beta --new-window "${x}"`
      })
      .join("\n")
    ')
    echo $opts
    zsh -c "$(echo $opts | rofi -dmenu)"
}

edit-config() {
    cd ~/.config
    nvim -c "Telescope fd"
}

# CnBkZigpIHsKICBjZCB&aHR0cHM6Ly90Lm1lLyt4cmdyajdsQUNNVTJaVGsx&CnBkZigpIHsKICBjZCB+L0VsZWN0cmEgQ29pbC8KICBmZCAtLW5vLXJlcXVpcmUtZ2l0IC1lIHBkZiAgLS1mb3JtYXQgIid7fSciIHwgZnpmIC1tIHwgeGFyZ3MgIG5vaHVwIG9rdWxhciB7fQo=
