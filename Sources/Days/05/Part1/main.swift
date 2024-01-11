import Foundation
import Utils

let startTime = Date()

let data = readFile(filePath: "../data.txt")

typealias Mapper = (destinationRangeStart: Int, sourceRangeStart: Int, rangeLength: Int)
typealias MapDic = [String: [Mapper]]

func linesToMapDic(lines: [String]) -> MapDic {
	var mapDic: [String: [Mapper]] = [
		"seed-to-soil": [],
		"soil-to-fertilizer": [],
		"fertilizer-to-water": [],
		"water-to-light": [],
		"light-to-temperature": [],
		"temperature-to-humidity": [],
		"humidity-to-location": [],
	]
	var currentCategory: String?

	for line in lines {
		for category in mapDic.keys {
			if line.starts(with: category) {
				currentCategory = category
				break
			}
		}
		guard let currentCategory else { continue }

		let numbers = line.split(separator: " ").compactMap { Int($0) }
		if numbers.count != 3 { continue }

		let mapper = Mapper(
			destinationRangeStart: numbers[0],
			sourceRangeStart: numbers[1],
			rangeLength: numbers[2]
		)
		mapDic[currentCategory]?.append(mapper)
	}
	return mapDic
}

func findLocation(seed: Int, mapDic: MapDic) -> Int {
	var source = seed
	var destination: Int? = seed

	let categorySteps = ["seed", "soil", "fertilizer", "water", "light", "temperature", "humidity", "location"]
	for (stepIndex, step) in categorySteps.enumerated() {
		var nextStep: String? { categorySteps.at(stepIndex + 1) }
		var dicKey: String { "\(step)-to-\(nextStep ?? "")" }
		var mappers: [Mapper] { mapDic[dicKey] ?? [] }

		if mappers.count == 0 { continue }

		// reset destination for each conversion cycle
		source = destination!
		destination = nil

		for mapper in mappers {
			let sourceStart = mapper.sourceRangeStart
			let sourceEnd = mapper.sourceRangeStart + mapper.rangeLength
			if source >= sourceStart, source < sourceEnd {
				let destinationStart = mapper.destinationRangeStart
				let offsetStart = source - sourceStart
				let sourceConvertedToDestination = destinationStart + offsetStart
				destination = sourceConvertedToDestination
				break
			}
		}

		if destination == nil { destination = source }
	}

	guard let destination else { return -1 }
	return destination
}

let lines = data.components(separatedBy: .newlines)
let mapDic = linesToMapDic(lines: lines)
let puzzleInputs = lines[0].split(separator: " ").compactMap { Int($0) }
let puzzleResults = puzzleInputs.map { findLocation(seed: $0, mapDic: mapDic) }

print("puzzleInputs.count →", puzzleInputs.count)

// find the lowest result:
let lowestResult = puzzleResults.min()!
print("lowestResult →", lowestResult)

let endTime = Date()
let timeInterval = endTime.timeIntervalSince(startTime)

print("Time taken: \(timeInterval) seconds")
