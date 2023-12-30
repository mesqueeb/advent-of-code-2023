import Foundation

public func destructure<T>(_ array: [T]) -> (T?, T?) {
	guard array.count >= 2 else {
		return (nil, nil)
	}
	return (array[0], array[1])
}
