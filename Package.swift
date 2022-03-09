// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Router",
            targets: ["Router"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Router",
            dependencies: [])
    ]
)
