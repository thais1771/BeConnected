// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BeConnected",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BeConnected",
            targets: ["BeConnected"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "BeConnected",
            dependencies: [])
    ]
)
