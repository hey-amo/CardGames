// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlayingCardKit",
    platforms: [
        .iOS(.v13),
        .tvOS(.v16),
        .macOS(.v10_15),
        .watchOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PlayingCardKit",
            targets: ["PlayingCardKit"]),
    ],
    targets: [
        .target(
            name: "PlayingCardKit",
            resources: [
                .process("Cards.xcassets")
            ]
        ),
        .testTarget(
            name: "PlayingCardKitTests",
            dependencies: ["PlayingCardKit"]
        ),
    ]
)
