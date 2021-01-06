// swift-tools-version:5.2

import PackageDescription

let package = Package(
   name: "ReplaceImageUrlPlugin",
   products: [
      // Products define the executables and libraries a package produces, and make them visible to other packages.
      .library(
         name: "ReplaceImageUrlPlugin",
         targets: ["ReplaceImageUrlPlugin"]),
   ],
   dependencies: [
      // Dependencies declare other packages that this package depends on.
      // .package(url: /* package url */, from: "1.0.0"),
      .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.1.0"),
      .package(name: "Ink", url: "https://github.com/johnsundell/ink.git", from: "0.2.0")      
   ],
   targets: [
      // Targets are the basic building blocks of a package. A target can define a module or a test suite.
      // Targets can depend on other targets in this package, and on products in packages this package depends on.
      .target(
         name: "ReplaceImageUrlPlugin",
         dependencies: ["Publish", "Ink"]),
      .testTarget(
         name: "ReplaceImageUrlPluginTests",
         dependencies: ["ReplaceImageUrlPlugin"]),
   ]
)
