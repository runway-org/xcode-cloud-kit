public protocol XcodeCloudKit {
}

final class DefaultXcodeCloudKit: XcodeCloudKit {
    private let transport: Transport
    
    init(transport: Transport) {
        self.transport = transport
    }
}
