import Foundation

// Get the directory of the current script file
let scriptDir = URL(fileURLWithPath: #file).deletingLastPathComponent()

// Assuming the file is in the current directory
let fileName = "data.txt"

// Construct the file URL
let fileURL = scriptDir.appendingPathComponent(fileName)

do {
	// Read the content of the file
	let content = try String(contentsOf: fileURL, encoding: .utf8)

	// Split the content into lines
	let lines = content.components(separatedBy: .newlines)

	var total = 0

	let replaceDic = [
		"one": "1",
		"two": "2",
		"three": "3",
		"four": "4",
		"five": "5",
		"six": "6",
		"seven": "7",
		"eight": "8",
		"nine": "9",
	]

	for var line in lines {
		for (key, value) in replaceDic {
			// issue when just replacing key with value is cases like "twone"
			line = line.replacingOccurrences(of: key, with: String(key + value + key))
		}
		let digits = line.compactMap { Int(String($0)) }
		let firstDigit = digits.first ?? 0
		let lastDigit = digits.last ?? 0
		let number = Int(String("\(firstDigit)\(lastDigit)")) ?? 0
		total += number
	}
	print("total: \(total)")
} catch {
	print("Error reading the file: \(error)")
}
