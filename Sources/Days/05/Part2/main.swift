import Dispatch
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
let puzzleInputInts = lines[0].split(separator: " ").compactMap { Int($0) }

var puzzleInputPairs: [(startIndex: Int, range: Int)] = {
	var result: [(startIndex: Int, range: Int)] = []
	for (index, number) in puzzleInputInts.enumerated() {
		if index % 2 == 0 {
			result.append((startIndex: number, range: puzzleInputInts[index + 1]))
		}
	}
	return result
}()

/// Let's try with one pair
let pair = puzzleInputPairs[0]
let resultQueue = DispatchQueue(label: "resultQueue") // Serial queue for thread safety
var lowestResult = Int.max

DispatchQueue.concurrentPerform(iterations: min(pair.range, 1_000_000)) { index in
	let seed = pair.startIndex + index
	let result = findLocation(seed: seed, mapDic: mapDic)
	// Process the result here
	resultQueue.sync {
		if result < lowestResult {
			lowestResult = result
		}
	}
}

// STUCK: 1 million iterations takes 10 seconds, we need to do 2.5 billion, which would take 8 hours.

// find the lowest result:
print("lowestResult →", lowestResult)

let endTime = Date()
let timeInterval = endTime.timeIntervalSince(startTime)

print("Time taken: \(timeInterval) seconds")
