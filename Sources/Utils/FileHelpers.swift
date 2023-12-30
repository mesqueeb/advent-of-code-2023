import Foundation

/// The `filePath` should be relative to the file that is executing `readFile`.
public func readFile(filePath: String, callerFilePath: String = #filePath) -> String {
	let callerFileURL = URL(fileURLWithPath: callerFilePath)
	let callerDir = callerFileURL.deletingLastPathComponent()

	// Construct the file URL
	let fileURL = callerDir.appendingPathComponent(filePath)

	do {
		// Read the content of the file
		return try String(contentsOf: fileURL, encoding: .utf8)
	} catch {
		print("Error reading the file: \(error)")
		return ""
	}
}
