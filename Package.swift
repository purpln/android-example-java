// swift-tools-version: 6.1

import PackageDescription

let package = Package(name: "Library", products: [
    .library(name: "Library", type: .dynamic, targets: ["Library"]),
], dependencies: [
    .package(url: "https://github.com/purpln/android-assets.git", branch: "main"),
    .package(url: "https://github.com/purpln/android-log.git", branch: "main"),
    .package(url: "https://github.com/purpln/ndk.git", branch: "main"),
    //.package(url: "https://github.com/purpln/java.git", branch: "main"),
    .package(path: "~/github/java"),
], targets: [
    .target(name: "Library", dependencies: [
        .product(name: "AndroidAssets", package: "android-assets"),
        .product(name: "AndroidLog", package: "android-log"),
        .product(name: "NDK", package: "ndk"),
        .product(name: "Java", package: "java"),
    ], linkerSettings: [
        .linkedLibrary("android"),
    ]),
])
