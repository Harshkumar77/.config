#!/usr/bin/env -S node

const keys: Keys = {
  screenshotMode: "full",
  modTabMode: "alternative",
}



















type Keys = {
  screenshotMode: "full" | "window",
  modTabMode: "alternative" | "cycle-forward" | "cycle-backward",
}
const key = process.argv[2]

console.log(
  keys[key] ?? "fake"
);
