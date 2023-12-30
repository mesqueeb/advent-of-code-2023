// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2023",
    platforms: [.macOS(.v14)],
    targets: [
        // Utils library target
        .target(
            name: "Utils",
            dependencies: [],
            path: "Sources/Utils"
        ),
        // Executable targets with dependency on Utils
        .executableTarget(
            name: "Day01Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/01/Part1"
        ),
        .executableTarget(
            name: "Day01Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/01/Part2"
        ),
        .executableTarget(
            name: "Day02Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/02/Part1"
        ),
        .executableTarget(
            name: "Day02Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/02/Part2"
        ),
        .executableTarget(
            name: "Day03Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/03/Part1"
        ),
        .executableTarget(
            name: "Day03Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/03/Part2"
        ),
        .executableTarget(
            name: "Day04Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/04/Part1"
        ),
        .executableTarget(
            name: "Day04Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/04/Part2"
        ),
        .executableTarget(
            name: "Day05Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/05/Part1"
        ),
        .executableTarget(
            name: "Day05Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/05/Part2"
        ),
        .executableTarget(
            name: "Day06Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/06/Part1"
        ),
        .executableTarget(
            name: "Day06Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/06/Part2"
        ),
        .executableTarget(
            name: "Day07Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/07/Part1"
        ),
        .executableTarget(
            name: "Day07Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/07/Part2"
        ),
        .executableTarget(
            name: "Day08Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/08/Part1"
        ),
        .executableTarget(
            name: "Day08Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/08/Part2"
        ),
        .executableTarget(
            name: "Day09Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/09/Part1"
        ),
        .executableTarget(
            name: "Day09Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/09/Part2"
        ),
        .executableTarget(
            name: "Day10Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/10/Part1"
        ),
        .executableTarget(
            name: "Day10Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/10/Part2"
        ),
        .executableTarget(
            name: "Day11Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/11/Part1"
        ),
        .executableTarget(
            name: "Day11Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/11/Part2"
        ),
        .executableTarget(
            name: "Day12Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/12/Part1"
        ),
        .executableTarget(
            name: "Day12Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/12/Part2"
        ),
        .executableTarget(
            name: "Day13Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/13/Part1"
        ),
        .executableTarget(
            name: "Day13Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/13/Part2"
        ),
        .executableTarget(
            name: "Day14Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/14/Part1"
        ),
        .executableTarget(
            name: "Day14Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/14/Part2"
        ),
        .executableTarget(
            name: "Day15Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/15/Part1"
        ),
        .executableTarget(
            name: "Day15Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/15/Part2"
        ),
        .executableTarget(
            name: "Day16Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/16/Part1"
        ),
        .executableTarget(
            name: "Day16Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/16/Part2"
        ),
        .executableTarget(
            name: "Day17Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/17/Part1"
        ),
        .executableTarget(
            name: "Day17Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/17/Part2"
        ),
        .executableTarget(
            name: "Day18Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/18/Part1"
        ),
        .executableTarget(
            name: "Day18Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/18/Part2"
        ),
        .executableTarget(
            name: "Day19Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/19/Part1"
        ),
        .executableTarget(
            name: "Day19Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/19/Part2"
        ),
        .executableTarget(
            name: "Day20Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/20/Part1"
        ),
        .executableTarget(
            name: "Day20Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/20/Part2"
        ),
        .executableTarget(
            name: "Day21Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/21/Part1"
        ),
        .executableTarget(
            name: "Day21Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/21/Part2"
        ),
        .executableTarget(
            name: "Day22Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/22/Part1"
        ),
        .executableTarget(
            name: "Day22Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/22/Part2"
        ),
        .executableTarget(
            name: "Day23Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/23/Part1"
        ),
        .executableTarget(
            name: "Day23Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/23/Part2"
        ),
        .executableTarget(
            name: "Day24Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/24/Part1"
        ),
        .executableTarget(
            name: "Day24Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/24/Part2"
        ),
        .executableTarget(
            name: "Day25Part1",
            dependencies: ["Utils"],
            path: "Sources/Days/25/Part1"
        ),
        .executableTarget(
            name: "Day25Part2",
            dependencies: ["Utils"],
            path: "Sources/Days/25/Part2"
        ),
    ]
)
