#!/usr/bin/env bun
import { randomBytes } from "node:crypto"

const bytes = Number.parseInt(process.argv[2] ?? "32", 10)
const key = `sk-${randomBytes(bytes).toString("base64url")}`

console.log(key)
