import Foundation
import Utils

let data = readFile(filePath: "../data.txt")

print(data)

// Split the content into lines
let lines = data.components(separatedBy: .newlines)

var total = 0

for line in lines {
	var cardScore = 0

	let parts = line.components(separatedBy: CharacterSet(charactersIn: "|:")).map { $0.trimmingCharacters(in: .whitespaces) }
	guard parts.count >= 3 else {
		continue
	}
	let card = parts[1]
	let ownNumbers = parts[2]
	let cardNumbers = card.split(separator: " ").compactMap { Int($0) }
	let winningNumbers = ownNumbers.split(separator: " ").compactMap { Int($0) }
	for cardNumber in cardNumbers {
		if winningNumbers.contains(cardNumber) {
			if cardScore == 0 {
				cardScore = 1
			} else {
				cardScore *= 2
			}
		}
	}
	total += cardScore
}

print("total →", total)
