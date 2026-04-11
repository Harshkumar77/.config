
import { readFileSync } from 'node:fs';
try {
  const contents = readFileSync(`${process.env.HOME}/.config/alias.zsh`, { encoding: 'utf8' });
  console.log(
    contents
      .split("\n")
      .filter(line => line.search("() {") !== -1 && line[0] !== ' ' && line[0] !== '#')
      .map(line => line.split("(")[0])
      .join("\n")
  );
} catch (err) {
  console.error(err.message);
}

