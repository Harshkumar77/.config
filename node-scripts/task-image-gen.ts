import fs from 'fs'
import path from 'path'

const o = new Array(21)
  .fill(0)
  .map((_, i) => {
  const today = new Date()
  let futureDate = new Date();
  futureDate.setDate(today.getDate() + i);
  let yyyy = futureDate.getFullYear();
  let mmm = futureDate.toLocaleString('en-US', { month: 'short' });
  let dd = String(futureDate.getDate()).padStart(2, '0');
  return `${yyyy}-${mmm}-${dd}`;
})
console.log(o);


const readDir = async dir => {
  const entries = await fs.promises.readdir(dir, { withFileTypes: true })
  const files = await Promise.all(entries.map(entry => {
    const res = path.resolve(dir, entry.name)
    return entry.isDirectory() ? readDir(res) : res
  }))
  return files.flat()
}

const extractMatches = async dir => {
  const files = await readDir(dir)
  const results = []

  for (const file of files) {
    const content = await fs.promises.readFile(file, 'utf8')
    const lines = content.split('\n')

    lines.forEach((line, idx) => {
      const match = line.match(/ #\d{4}-[A-Z][a-z]{2}-\d{2}/)
      if (match) {
        results.push({
          file,
          line: idx + 1,
          date: match[0],
          text: line
        })
      }
    })
  }

  return results
}

const main = async () => {
  const matches = await extractMatches('/mnt/c/notes/Daily Notes')
  o.map((date) => {
      return matches.map(obj => {
        if(obj.date === `#${date}`)
          return (obj.text)
        return 0
      })
  })
}

main().then(console.table)
