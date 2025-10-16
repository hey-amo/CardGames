// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TraditionalCardGames",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TraditionalCardGames",
            targets: ["TraditionalCardGames"]),
    ],
    dependencies: [
            // Local paths if all packages live in same repo:
            .package(path: "../PlayingCardKit"),
            .package(path: "../TCG_GameEngine")
            
            // OR if they’re on GitHub:
            // .package(url: "https://github.com/YourUser/PlayingCardKit.git", from: "1.0.0"),
            // .package(url: "https://github.com/YourUser/GameEngine.git", from: "1.0.0")
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TraditionalCardGames",
            dependencies: [
                            "PlayingCardKit",
                            "TCG_GameEngine"
                        ]
            ),
        .testTarget(
            name: "TraditionalCardGamesTests",
            dependencies: ["TraditionalCardGames"]
        ),
    ]
)
