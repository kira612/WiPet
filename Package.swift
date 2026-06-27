// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WiPet",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "WiPetCore",
            targets: ["WiPetCore"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.19.2")
    ],
    targets: [
        .target(name: "WiPetCore"),
        .testTarget(
            name: "WiPetCoreTests",
            dependencies: [
                "WiPetCore",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: ["__Snapshots__"]
        )
    ]
)
