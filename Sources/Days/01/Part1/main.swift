import Foundation

// Get the directory of the current script file
let scriptDir = URL(fileURLWithPath: #file).deletingLastPathComponent()

// Assuming the file is in the current directory
let fileName = "../data.txt"

// Construct the file URL
let fileURL = scriptDir.appendingPathComponent(fileName)

do {
	// Read the content of the file
	let data = try String(contentsOf: fileURL, encoding: .utf8)

	// Split the content into lines
	let lines = data.components(separatedBy: .newlines)

	var total = 0

	for line in lines {
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
