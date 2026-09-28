// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-source",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Source",
            targets: ["Source"]
        ),
        .library(
            name: "Source Standard Library Integration",
            targets: ["Source Standard Library Integration"]
        ),
        .library(
            name: "Source Apple Foundation Integration",
            targets: ["Source Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-text.git",
            branch: "main", traits: ["Byte"]
        ),
    ],
    targets: [
        .target(
            name: "Source",
            dependencies: [
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Text", package: "swift-text"),
            ]
        ),
        .target(
            name: "Source Standard Library Integration",
            dependencies: ["Source", .product(name: "Text", package: "swift-text")]
        ),
        .target(
            name: "Source Apple Foundation Integration",
            dependencies: [
                "Source",
                "Source Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Source Tests",
            dependencies: ["Source", .product(name: "Text", package: "swift-text"), .product(name: "Byte", package: "swift-byte")],
            path: "Tests/Source Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
