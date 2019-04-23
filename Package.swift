// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "BatchUpdates",
  platforms: [
    .iOS(.v11)
  ],
  products: [
    .library(
      name: "BatchUpdates",
      targets: ["BatchUpdates"]),
  ],
  targets: [
    .target(
      name: "BatchUpdates",
      dependencies: []),
    .testTarget(
      name: "BatchUpdatesTests",
      dependencies: ["BatchUpdates"]),
  ]
)
