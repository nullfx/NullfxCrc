// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "NullfxCrc",
    products: [
        .library(
            name: "NullfxCrc",
            targets: ["NullfxCrc"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "NullfxCrc",
            dependencies: []),
        .testTarget(
            name: "NullfxCrcTests",
            dependencies: ["NullfxCrc"]),
    ]
)
