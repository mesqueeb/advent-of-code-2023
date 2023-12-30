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
	let gameData = parseGameData(gameNotes: line)

	// For each game, find the minimum set of cubes that must have been present. *What is the sum of the power of these sets?*
	// The *power* of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
	total += gameData.red * gameData.green * gameData.blue
}

print("total: \(total)")
