rmf() {
    fd --maxdepth 1 | rofi -dmenu -multi-select -p "Select files to delete" | while IFS= read -r file; do
        rm -rf -- "$file"
    done
}

archive() {
    zsh -c "~/archive/create-backup.sh"
}

backup() {
    zsh -c "~/.config/scripts/backup.sh"
}

awesome-launch() {
    killall xfwm4 && awesome
}

xfce-launch() {
    killall awesome && xfwm4
}


alias vlc='nohup vlc'
alias mpv='nohup mpv'
alias bmpv='/bin/mpv'

alias mpv-newest='mpv "$(fd . /tmp -e mkv -X ls -t | head -1)"'

cmpv() {
    url=$(rofi -dmenu)
    cd ~/Temp 
    wget "$url" &
    mpv "$(fd . ~/Temp -X ls -t | head -1)"
}

alias wgetp='mpv "$(fd . ~/Temp -X ls -t | head -1)"; exit'
alias wget='wget --continue --content-disposition'


# alias extract-urls() {
#   curl $1 | xidel -e "//a/@href"'
# }

alias copy-file='xclip -selection clipboard < '

wallpaper() {
    sxiv ~/.config/wallpaper -qbf -s f -S 3
}


alias cdd='zi'

download-songs() {
    zsh -c "$(bun ~/.config/scripts/download-songs.ts)"
    bun ~/.config/scripts/conan.ts
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

dir-play() {
    fd . ~ -e mkv -e mp3 -e mp4 -x echo '{//}' | sort | uniq | rofi -dmenu | xargs -I{} nohup mpv '{}'
}

media() {
    p="$(fzf --bind "change:reload(fd . ~ -e mkv -e mp4 --and '{q}' -x echo {/.})" --print-query | head -1)"
    (fd . ~ -e mkv -e mp4 --and "$p" | sort) > /tmp/aa.m3u
    mpv /tmp/aa.m3u
}

mpv-video() {
    (fd -e mkv -e mp4 -e mp3 -e m4b -e mkv.part -e mp3.part -e mp4.part) > playlist.m3u
    xdg-open playlist.m3u
    sleep 3
    rm playlist.m3u
    exit
}

anime-latest() {
    cd ~
    (fd -e mkv -e mkv.part -X ls -t) > ~/Downloads/playlist.m3u
    xdg-open ~/Downloads/playlist.m3u
    sleep 3
    rm ~/Downloads/playlist.m3u
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

play-long-on-start() {
    mpv ~/Music/Long/Long.m3u --pause --loop-playlist=yes --shuffle --no-save-position-on-quit
}

play-song-on-start() {
    mpv ~/Music/Song/Song.m3u --pause --loop-playlist=yes --shuffle --no-save-position-on-quit
}


play() {
    p=$(fd . ~/Music -e m3u)
    pp=$(bun -p "
      \`$p\`
        .split('\n')
        .map(y => y.split('/').pop().split('.')[0])
        .join('\n')
      " | rofi -dmenu)
    ppp=$(fd . ~/Music -e m3u --and "$pp" | head -1)
    nohup mpv "$ppp" --pause --loop-playlist=yes --shuffle --no-save-position-on-quit  >/dev/null
}


pdf() {
    p=$(fd . "$HOME/Electra Coil/" -e pdf --no-ignore -x echo '{/.}' | rofi -dmenu -multi-select)
    search_str=$(bun -p "
      \`$p\`.split('\n').join('|')
    ")
    fd . "$HOME/Electra Coil/" -e pdf --no-ignore --and "$search_str" | xargs -I{} thunar '{}'
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
    opts=$(bun -p '[
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
        return `firefox --new-window "${x}"`
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

buffer() {
    nohup obsidian "obsidian://adv-uri?vault=Electra%20Coil&filepath=buffer.md"
}

yt-mpv() {
    url=$(copyq eval -- "
for(i=0;i<size();++i)
  print(str(read(i)) + '\n')
" | grep -oE 'https?://[^ ]+' | sort -u | rofi -dmenu -i -p "URL")

    method=$(printf "mpv\nyt-dlp -g" | rofi -dmenu -p "Method")

    [ -z "$url" ] && exit

    case "$method" in
        "mpv")
            mpv "$url"
            ;;
        "yt-dlp -g")
            yt-dlp -g "$url" | xargs mpv
            ;;
    esac
}

alias 10_min_and_suspend='echo "Dont clost this";sleep 600 && systemctl suspend'
alias 15_min_and_suspend='echo "Dont clost this";sleep 900 && systemctl suspend'
alias 30_min_and_suspend='echo "Dont clost this";sleep 1800 && systemctl suspend'
alias 40_min_and_suspend='echo "Dont clost this";sleep 2400 && systemctl suspend'
alias 60_min_and_suspend='echo "Dont clost this";sleep 3600 && systemctl suspend'


# CnBkZigpIHsKICBjZCB&aHR0cHM6Ly90Lm1lLyt4cmdyajdsQUNNVTJaVGsx&CnBkZigpIHsKICBjZCB+L0VsZWN0cmEgQ29pbC8KICBmZCAtLW5vLXJlcXVpcmUtZ2l0IC1lIHBkZiAgLS1mb3JtYXQgIid7fSciIHwgZnpmIC1tIHwgeGFyZ3MgIG5vaHVwIG9rdWxhciB7fQo=
