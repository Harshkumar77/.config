import { readdirSync } from 'node:fs';
import { execSync } from 'node:child_process';
import { log } from 'node:console';
function isFileImage(file) {
  return ['webp', 'jpg', 'jpeg', 'png']
    .reduce(
      (previous, current) => previous || file.endsWith(current)
      , false)
}

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


try {

  const images = execSync( 'fd . ~/.config/wallpaper/ --max-depth=1 -e png -e jpg -e webp -e jpeg').toString().split('\n')

  const batch_images = [...images, ...shuffle(images), ...shuffle(images)].reduce((previous, current, i) => {
    if (i % 8 === 0) previous.push([])
    previous[previous.length - 1].push(current)
    return previous
  }, [])

  log(batch_images.map(_ => _.length))
} catch (err) {
  console.error(err.message);
}


