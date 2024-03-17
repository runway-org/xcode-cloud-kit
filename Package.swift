// swift-tools-version: 5.8

import PackageDescription

let settings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

let package = Package(
	name: "XcodeCloudKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14)
    ],
	products: [
		.library(name: "XcodeCloudKit", targets: ["XcodeCloudKit"]),
	],
    dependencies: [
        .package(url: "https://github.com/AvdLee/appstoreconnect-swift-sdk.git", exact: "3.2.0")
    ],
	targets: [
		.target(
			name: "XcodeCloudKit",
            dependencies: [
                .product(name: "AppStoreConnect-Swift-SDK", package: "appstoreconnect-swift-sdk")
            ],
			swiftSettings: settings
		),
		.testTarget(
			name: "XcodeCloudKitTests",
			dependencies: ["XcodeCloudKit"],
			swiftSettings: settings
		),
	]
)
