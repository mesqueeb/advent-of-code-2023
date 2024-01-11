import Foundation
import Utils

let startTime = Date()

let data = readFile(filePath: "../data.txt")

print(data)



let endTime = Date()
let timeInterval = endTime.timeIntervalSince(startTime)

print("Time taken: \(timeInterval) seconds")
