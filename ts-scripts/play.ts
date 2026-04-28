#!/usr/bin/env -S bun

import { randomInt } from 'node:crypto'

console.log(Array(1000000).fill(1).map(_ => randomInt(1000, 10000)).join(""));
