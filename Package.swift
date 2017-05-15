// swift-tools-version:3.1

import PackageDescription

let package = Package(
   name: "SwiftProtocolParser"
   , dependencies: [
      .Package(url: "../ParseKit", majorVersion: 0)
   ]
)
