import { readdirSync } from 'node:fs';
import { execSync } from 'node:child_process';
import { log } from 'node:console';
function isFileImage(file) {
  return ['webp', 'jpg', 'jpeg', 'png']
    .reduce(
      (previous, current) => previous || file.endsWith(current)
      , false)
}

/**
 * @param {Array<String>}
 * @param {number}
 * @return {Array<String>}
 */
function shuffle(arr, iter = 2) {
  if (iter === 0) return arr
  return shuffle(arr.reduce((previous, current, i) => {
    if (previous.length === 0)
      return [current]
    const x = Math.floor(Math.random() * (previous.length))
    const y = i
    const valx = previous[x]
    const valy = arr[y]
    previous[x] = valy
    previous.push(valx)
    return previous
  }, []), iter - 1)
}


/**
 * @param {string}
 * @param {string}
 * @param {string}
 * @param {String}
 *
 * @return {string}
 */
function montageCommand(s, w, h, name) {
  return `montage ${s} -tile ${w}x${h} -geometry 512x512 -background black -gravity center ~/.config/wallpaper/gen-desktop/${name}.png`
}



try {

  const images = execSync(`fd . ~/.config/wallpaper/ --max-depth=1 -e png -e jpg -e webp -e jpeg`)
    .toString()
    .split('\n')
    .map(_ => "'" + _ + "'")

  const batch_images = [...images, ...shuffle(images), ...shuffle(images)]
    .reduce((previous, current, i) => {
      if (i % 8 === 0) previous.push([])
      previous[previous.length - 1].push(current)
      return previous
    },
    /** @type {Array<String>} */([]))

  log(
    batch_images.map(batch => {
      `montage ${batch.join(" ")} -tile 4x2 -geometry 512x512 -background black -gravity center ~/.config/wallpaper/gen-desktop/outputR\${i}.png`
    })
  )

} catch (err) {
  console.error(err.message);
}
