import Foundation
import Utils

let data = readFile(filePath: "../data.txt")

typealias Number = (lineIndex: Int, value: Int, index: (from: Int, to: Int))
typealias SymbolIndex = (lineIndex: Int, symbolIndex: Int)

func lineToNumbers(_ lineIndex: Int, _ line: String) -> [Number] {
	var result: [Number] = []

	var numberStartedAt: Int = -1
	var numberStoppedAt: Int = -1
	for (i, character) in ("." + line + ".").enumerated() {
		if character.isNumber {
			if numberStartedAt == -1 {
				numberStartedAt = i
			}
			numberStoppedAt = i
		} else {
			if numberStoppedAt != -1 {
				let startIndex = line.index(line.startIndex, offsetBy: numberStartedAt - 1)
				let endIndex = line.index(line.startIndex, offsetBy: numberStoppedAt - 1)
				let numberString = String(line[startIndex ... endIndex])
				guard let numberValue = Int(numberString) else {
					print("wrong number parsing logic", numberString)
					return result
				}

				result.append(
					Number(
						lineIndex: lineIndex,
						value: numberValue,
						index: (from: numberStartedAt, to: numberStoppedAt)
					)
				)
			}
			// let's reset
			numberStartedAt = -1
			numberStoppedAt = -1
		}
	}
	return result
}

func lineToSymbolIndexes(_ lineIndex: Int, _ line: String) -> [SymbolIndex] {
	var result: [SymbolIndex] = []

	for (i, character) in ("." + line + ".").enumerated() {
		if character == "." { continue }
		let number = Int(String(character))
		if number != nil { continue }

		result.append(SymbolIndex(lineIndex: lineIndex, symbolIndex: i))
	}

	return result
}

func numberToPossibleSymbolIndexes(_ number: Number) -> [SymbolIndex] {
	var result: [SymbolIndex] = []

	let from = number.index.from
	let to = number.index.to

	let rangeArray = Array((from - 1) ... (to + 1))

	for possibileIndex in rangeArray {
		result.append(SymbolIndex(lineIndex: number.lineIndex - 1, symbolIndex: possibileIndex))
	}
	for possibileIndex in rangeArray {
		result.append(SymbolIndex(lineIndex: number.lineIndex, symbolIndex: possibileIndex))
	}
	for possibileIndex in rangeArray {
		result.append(SymbolIndex(lineIndex: number.lineIndex + 1, symbolIndex: possibileIndex))
	}

	return result
}

// Split the content into lines
let lines = data.components(separatedBy: .newlines)

var total = 0

var allSymbolIndexes: [SymbolIndex] = []
var allNumbers: [Number] = []

for (lineIndex, line) in lines.enumerated() {
	let lineNumbers = lineToNumbers(lineIndex, line)
	allNumbers.append(contentsOf: lineNumbers)
	let lineSymbolIndexes = lineToSymbolIndexes(lineIndex, line)
	allSymbolIndexes.append(contentsOf: lineSymbolIndexes)
}

for number in allNumbers {
	let possibleSymbolIndexes = numberToPossibleSymbolIndexes(number)
	for symbolIndex in allSymbolIndexes {
		if possibleSymbolIndexes.contains(where: { possibleSymbolIndex in symbolIndex.lineIndex == possibleSymbolIndex.lineIndex && symbolIndex.symbolIndex == possibleSymbolIndex.symbolIndex }) {
			total += number.value
		}
	}
}

print("total: \(total)")
