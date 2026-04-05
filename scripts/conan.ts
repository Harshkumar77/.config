const fs = require('node:fs');

["SongArchive", "LongArchive"]
  .forEach(fileNameWithoutExt => {
    try {
      const data = fs.
        readFileSync(`${process.env.HOME}/.config/media/${fileNameWithoutExt}.txt`, 'utf8')
        .split("\n")
        .map(_ => _.length > 4 ? `https://youtube.com/watch?v=${_.split(' ').pop()}` : "")
        .join("\n")
      try {
        fs.writeFileSync(`${process.env.HOME}/.config/media/${fileNameWithoutExt}-corrected.txt`, data);
      } catch (err) {
        console.error(err);
      }
    } catch (err) {
      console.error(err);
    }
  })
