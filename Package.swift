// swift-tools-version: 5.8

import PackageDescription

let settings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

let package = Package(
	name: "XcodeCloudKit",
	products: [
		.library(name: "XcodeCloudKit", targets: ["XcodeCloudKit"]),
	],
	targets: [
		.target(
			name: "XcodeCloudKit",
			swiftSettings: settings
		),
		.testTarget(
			name: "XcodeCloudKitTests",
			dependencies: ["XcodeCloudKit"],
			swiftSettings: settings
		),
	]
)
