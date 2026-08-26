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
            name: "Source Test Support",
            targets: ["Source Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-text.git",
            branch: "main"
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
            name: "Source Test Support",
            dependencies: [
                "Source",
                .product(name: "Text Test Support", package: "swift-text"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Source Tests",
            dependencies: [
                "Source",
                "Source Test Support",
            ],
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
