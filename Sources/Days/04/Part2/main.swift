import Foundation
import Utils

let startTime = Date()

let data = readFile(filePath: "../data.txt")

print(data)

// Split the content into lines
let lines = data.components(separatedBy: .newlines).filter { !$0.isEmpty }

var cardIndexCopyCountDic: [Int: Int] = [:]

for (lineIndex, line) in lines.enumerated() {
	let cardCopiesForThisLine = 1 + (cardIndexCopyCountDic[lineIndex] ?? 0)
	cardIndexCopyCountDic[lineIndex] = cardCopiesForThisLine

	let parts = line.components(separatedBy: CharacterSet(charactersIn: "|:")).map { $0.trimmingCharacters(in: .whitespaces) }
	guard parts.count >= 3 else {
		continue
	}
	let card = parts[1]
	let ownNumbers = parts[2]
	let cardNumbers = card.split(separator: " ").compactMap { Int($0) }
	let winningNumbers = Set(ownNumbers.split(separator: " ").compactMap { Int($0) })

	var cardCopiesWonFromThisLine = 0
	for cardNumber in cardNumbers {
		if winningNumbers.contains(cardNumber) {
			cardCopiesWonFromThisLine += 1
		}
	}

	if cardCopiesWonFromThisLine > 0 {
		for _ in 1 ... cardCopiesForThisLine {
			for copyNr in 1 ... cardCopiesWonFromThisLine {
				cardIndexCopyCountDic[lineIndex + copyNr, default: 0] += 1
			}
		}
	}
}

var total = cardIndexCopyCountDic.values.reduce(0) { total, count in total + count }
print("total →", total)

let endTime = Date()
let timeInterval = endTime.timeIntervalSince(startTime)

print("Time taken: \(timeInterval) seconds")
