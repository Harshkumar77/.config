#!/usr/bin/env -S bun

import type { Keys } from './types'

const keys: Keys = {
  screenshotMode: "full",
  modTabMode: "alternative",
}



















const key = process.argv[2]

console.log(
  keys[key] ?? "fake"
);
