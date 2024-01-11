import { promises as fs } from 'fs'
import { JSDOM } from 'jsdom'
import fetch from 'node-fetch'
import { env } from 'process'

const YEAR = 2023
const day = String(process.argv[2] ?? new Date().getDate())
const dayPadded = day.padStart(2, '0')

console.log(`Importing day ${day}.`)

const [{ instructions, examples }, input] = await Promise.all([getInstructions(), getInput()])

console.log(`instructions → `, instructions)

try {
  await fs.mkdir(`Sources/Days/${dayPadded}/Part1/`, { recursive: true })
  await fs.mkdir(`Sources/Days/${dayPadded}/Part2/`, { recursive: true })
} catch (e) {
  console.log(e)
}

await fs.writeFile(`Sources/Days/${dayPadded}/data.txt`, input)
await fs.writeFile(`Sources/Days/${dayPadded}/README.md`, instructions)
try {
  const template = `import Foundation
import Utils

let startTime = Date()

let data = readFile(filePath: "../data.txt")

print(data)



let endTime = Date()
let timeInterval = endTime.timeIntervalSince(startTime)

print("Time taken: \(timeInterval) seconds")
`
  if (!(await fileExists(`Sources/Days/${dayPadded}/Part1/main.swift`))) {
    await fs.writeFile(`Sources/Days/${dayPadded}/Part1/main.swift`, template)
  }
  if (!(await fileExists(`Sources/Days/${dayPadded}/Part2/main.swift`))) {
    await fs.writeFile(`Sources/Days/${dayPadded}/Part2/main.swift`, template)
  }
} catch {}

await Promise.all(
  examples.map((example, idx) =>
    fs.writeFile(`Sources/Days/${dayPadded}/ex${idx + 1}.txt`, example)
  )
)

console.log(`Files written`)

async function getInput() {
  const page = await fetch(`https://adventofcode.com/${YEAR}/day/${day}/input`, {
    headers: {
      Cookie: `session=${env.AOC_SESSION}`,
    },
  })

  return page.text()
}

async function getInstructions() {
  const page = await fetch(`https://adventofcode.com/${YEAR}/day/${day}`, {
    headers: {
      Cookie: `session=${env.AOC_SESSION}`,
    },
  })

  const data = await page.text()
  const dom = new JSDOM(data)
  const doc = dom.window.document
  const nodes = []
  const exampleCases = new Set()
  for (const node of doc?.querySelectorAll('article > *') || []) {
    switch (node.tagName) {
      case 'H2':
        nodes.push(`# ${node.textContent}`)
        break
      case 'PRE':
        nodes.push(`\`\`\`\n${node.textContent}\n\`\`\``)
        exampleCases.add(node.textContent)
        break
      case 'UL':
        nodes.push([...node.children].map((x) => `- ${x.textContent}`).join('\n'))
        break
      case 'P':
        {
          const cp = node.cloneNode(true)
          cp.querySelectorAll('*').forEach((item) => {
            const el = item
            return el.replaceWith(
              el.tagName === 'CODE'
                ? `\`${el.textContent}\``
                : el.tagName === 'EM'
                ? `*${item.textContent}*`
                : el
            )
          })
          nodes.push(cp.textContent)
        }
        break
      default:
        console.log(node.tagName, 'Not supported')
    }
  }
  return { instructions: nodes.join('\n\n'), examples: [...exampleCases] }
}

async function fileExists(path) {
  try {
    await fs.access(path)
    return true
  } catch {
    return false
  }
}
