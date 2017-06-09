// swift-tools-version:3.1

import PackageDescription

let package = Package(
   name: "SwiftProtocolParser"
   , dependencies: [
      .Package(url: "git@bitbucket.org:bigfrancoag/parsekit.git", majorVersion: 0)
   ]
)
