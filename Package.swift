// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "MoonKit",
  platforms: [
      .macOS(.v10_13),
      .iOS(.v9),
      .watchOS(.v3),
      .tvOS(.v9)
  ],
  products: [
    .library(
      name: "MoonKit",
      targets: ["MoonKit"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "MoonKit",
      dependencies: []
    ),
    .testTarget(
      name: "MoonKitTests",
      dependencies: ["MoonKit"]
    )
  ]
)
