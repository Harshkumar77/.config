#!/usr/bin/env -S bun

import type { Keys } from './types'

const keys: Keys = {
  screenshotMode: "full",
  modTabMode: "alternative",
  singleTapMod: true,
  titleBarEnabled: true,
  keyboardNative: true,
}



















const key = process.argv[2] ?? ""

console.log(
  Object.hasOwn(keys, key) ? keys[key as keyof typeof keys] : "fake"
)
