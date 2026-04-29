#!/usr/bin/env -S bun

import type { Keys } from './types'

const keys: Keys = {
  screenshotMode: "window",
  modTabMode: "alternative",
}



















const key = process.argv[2] ?? ""

process.stdout.write(
  Object.hasOwn(keys, key) ? keys[key as keyof typeof keys] : "fake"
)
