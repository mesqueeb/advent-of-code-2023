import Foundation
import Utils

typealias ColorMaxCountDic = (red: Int, green: Int, blue: Int)

func parseGameNumber(gameNotes: String) -> Int {
	let number = gameNotes.split(separator: ": ").first?.split(separator: " ").last ?? "0"
	return Int(number) ?? 0
}

func parseGameData(gameNotes: String) -> ColorMaxCountDic {
	var dic = ["red": 0, "green": 0, "blue": 0]

	let sets = gameNotes.split(separator: ": ").last?.split(separator: ";") ?? []

	for set in sets {
		let colors = set.trimmingCharacters(in: .whitespaces).split(separator: ",")

		for colorData in colors {
			let (_count, _color) = destructure(colorData.trimmingCharacters(in: .whitespaces).split(separator: " "))
			let count = Int(_count ?? "") ?? 0
			let color = String(_color ?? "blue")
			if dic[color] ?? 0 < count {
				dic[color] = count
			}
		}
	}
	return (
		red: dic["red"] ?? 0,
		green: dic["green"] ?? 0,
		blue: dic["blue"] ?? 0
	)
}

let data = readFile(filePath: "../data.txt")
// Split the content into lines
let lines = data.components(separatedBy: .newlines)

var total = 0

for line in lines {
	let gameNr = parseGameNumber(gameNotes: line)
	let gameData = parseGameData(gameNotes: line)

	// Determine which games would have been possible if the bag had been loaded with only
	// 12 red cubes, 13 green cubes, and 14 blue cubes.

	let maxRed = 12
	let maxGreen = 13
	let maxBlue = 14

	if gameData.red <= maxRed, gameData.green <= maxGreen, gameData.blue <= maxBlue {
		// *What is the sum of the IDs of those games?*
		total += gameNr
	}
}

print("total: \(total)")
