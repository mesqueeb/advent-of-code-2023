import Foundation
import Utils

let data = readFile(filePath: "../data.txt")

typealias Number = (lineIndex: Int, value: Int, index: (from: Int, to: Int))
typealias GearIndex = (lineIndex: Int, gearIndex: Int)

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

func lineToGearIndexes(_ lineIndex: Int, _ line: String) -> [GearIndex] {
	var result: [GearIndex] = []

	for (i, character) in ("." + line + ".").enumerated() {
		if character == "." { continue }
		let number = Int(String(character))
		if number != nil { continue }

		result.append(GearIndex(lineIndex: lineIndex, gearIndex: i))
	}

	return result
}

func numberToPossibleGearIndexes(_ number: Number) -> [GearIndex] {
	var result: [GearIndex] = []

	let from = number.index.from
	let to = number.index.to

	let rangeArray = Array((from - 1) ... (to + 1))

	for possibileIndex in rangeArray {
		result.append(GearIndex(lineIndex: number.lineIndex - 1, gearIndex: possibileIndex))
	}
	for possibileIndex in rangeArray {
		result.append(GearIndex(lineIndex: number.lineIndex, gearIndex: possibileIndex))
	}
	for possibileIndex in rangeArray {
		result.append(GearIndex(lineIndex: number.lineIndex + 1, gearIndex: possibileIndex))
	}

	return result
}

// Split the content into lines
let lines = data.components(separatedBy: .newlines)

var total = 0

var allGearIndexes: [GearIndex] = []
var allNumbers: [Number] = []

for (lineIndex, line) in lines.enumerated() {
	let lineNumbers = lineToNumbers(lineIndex, line)
	allNumbers.append(contentsOf: lineNumbers)
	let lineGearIndexes = lineToGearIndexes(lineIndex, line)
	allGearIndexes.append(contentsOf: lineGearIndexes)
}

for gearIndex in allGearIndexes {
	var numbersAdjacent: [Number] = []
	for number in allNumbers {
		let possibleGearIndexes = numberToPossibleGearIndexes(number)
		if possibleGearIndexes.contains(where: { possibleGearIndex in gearIndex.lineIndex == possibleGearIndex.lineIndex && gearIndex.gearIndex == possibleGearIndex.gearIndex }) {
			numbersAdjacent.append(number)
		}
	}
	if numbersAdjacent.count == 2 {
		total += numbersAdjacent[0].value * numbersAdjacent[1].value
	}
}

print("total: \(total)")
