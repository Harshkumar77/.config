#!/usr/bin/env zsh

cd ~/Music/rap/
url="https://www.youtube.com/playlist?list=PLuDbTR3nQ_ZVrBK2Xsf1jXE-qXtD_kOiD&pp=gAQB" 
yt-dlp --embed-thumbnail --sponsorblock-remove all -f 'ba[acodec^=mp3]/ba/b' -x --audio-format mp3 "$url"

cd ~/Music/anime/
url="https://www.youtube.com/playlist?list=PLuDbTR3nQ_ZXXAhO78F1b5eFtJJDQ2cZ8&pp=gAQB" 
yt-dlp  -f 'ba[acodec^=mp3]/ba/b' -x --audio-format mp3 "$url"

cd ~/Music/melt
url="https://www.youtube.com/playlist?list=PLuDbTR3nQ_ZV5KbLw1w-s1Tmhq0g--4S7" 
yt-dlp --flat-playlist --embed-thumbnail --sponsorblock-remove all -f 'ba[acodec^=mp3]/ba/b' -x --audio-format mp3 "$url"

cd ~/Videos/YT/JMULV/
yt-dlp --flat-playlist -S res:480 "https://www.youtube.com/playlist?list=PLuDbTR3nQ_ZWx0ugL5mno6uzcq_64Qq4J&pp=gAQB" 
