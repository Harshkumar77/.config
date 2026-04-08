console.log("pipx upgrade yt-dlp");

console.log(
  [
    [
      "Song",
      "https://music.youtube.com/playlist?list=PLuDbTR3nQ_ZWl8j7gGxphy9vu9CL_ASSf",
    ],
    [
      "Long",
      "https://music.youtube.com/playlist?list=PLuDbTR3nQ_ZUMRQGIydDRGe3lheNrPkYj",
    ]
  ]
    .map(([key, url]) => {
      return `
          mkdir ~/Music/${key}/ -p
          cd ~/Music/${key}
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
            --download-archive ~/.config/media/${key}Archive.txt \
          "${url}"
      echo "#EXTM3U" > ${key}.m3u
      fd -e mp3 >> ${key}.m3u`
    }).join("\n")
);
console.log('node ~/.config/scripts/conan.ts');
