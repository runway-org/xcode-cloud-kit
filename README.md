# XcodeCloudKit

The Swift SDK that makes working with the Xcode Cloud endpoints from the App Store Connect API a breeze!

[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]

[build status]: https://github.com/runway-org/xcode-cloud-kit/actions
[build status badge]: https://github.com/runway-org/xcode-cloud-kit/workflows/CI/badge.svg
[platforms]: https://swiftpackageindex.com/runway-org/xcode-cloud-kit
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattmassicotte%2FPackageTemplate%2Fbadge%3Ftype%3Dplatforms

## How to use `XcodeCloudKit`?

`XcodeCloudKit` relies on [Antoine Van Der Lee's appstoreconnect-swift-sdk](https://github.com/AvdLee/appstoreconnect-swift-sdk), which provides a fantastic Swift interface to interact with the App Store Connect API.

The App Store Connect API requires all network requests to be authenticated and, as it does not support OAuth, you must create an API key from the dashboard.

Once you have generated a key, you must initialise the SDK by using its `Factory` enum:

```swift
import XcodeCloudKit

let xcodeCloudKit = try Factory.make(
    issuerID: "🙈",
    privateKeyID: "🙈",
    privateKey: "🙈"
)
```

`XcodeCloudKit`'s structure tries to mirror Xcode Cloud's data structure as closely as possible and has three main entities: **products**, **workflows** and **build**s.

**Product**s are the Xcode Cloud representations of your app and you can request a list of them and select one using the SDK:

```swift
// Get a list of all available products
let allProducts = try await xcodeCloudKit.allProducts()
// Get a product by Xcode Cloud ID
let productById = try await xcodeCloudKit.product(withId: "...")
// By repository name
let product = try await xcodeCloudKit.product(withRepositoryName: "NowPlaying")
```

Once you have a product, you can access one or all of its **workflows**, which are the blueprints of your CI/CD pipelines, directly on the instance:

```swift
// Get a list of all available workflows
let allWorkflows = try await product?.workflows()
// Get a workflow by Xcode Cloud ID
let workflowByID = try await product?.workflow(withId: "...")
// Get a workflow by name
let workflow = try await product?.workflow(withName: "Test Workflow")
```

Once you have a **workflow**, you can access the list of **builds** or workflow runs for a specific workflow:

```swift
// Get a list of all available builds
let allBuilds = try await workflow?.allBuilds()
// Get a build by its number
let build = try await workflow?.build(withNumber: 32)
```

And you can even start a new **build** for a specific workflow at a git reference of your choice:

```swift
try await workflow?.start(atGitReference: .branch(name: "main"))
```

> Note that the SDK's functionalities are limited at the moment and more features will get added in the coming days and months.

## Installation

As it stands, `XcodeCloudKit` can only be installed via SPM as follows:

```swift
dependencies: [
    .package(url: "https://github.com/runway-org/xcode-cloud-kit.git", .upToNextMajor(from: "0.1.0"))
]
```

## License

**XcodeCloudKit** is available under the MIT license, and uses source code from open source projects. See the [LICENSE](./LICENSE) file for more info.

## Author

This project is developed and maintained open source by [Runway](https://twitter.com/RunwayTeam) and lead by [Pol Piella Abadia](https://twitter.com/polpielladev).