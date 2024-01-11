import Foundation

public func destructure<T>(_ array: [T]) -> (T?, T?) {
	guard array.count >= 2 else {
		return (nil, nil)
	}
	return (array[0], array[1])
}

public extension Array {
	/// Similar to JS's `.at()`
	func at(_ index: Int) -> Element? {
		// Check for negative indices
		let effectiveIndex = index >= 0 ? index : count + index

		// Return nil if index is out of range
		guard effectiveIndex >= 0, effectiveIndex < count else {
			return nil
		}

		return self[effectiveIndex]
	}
}
