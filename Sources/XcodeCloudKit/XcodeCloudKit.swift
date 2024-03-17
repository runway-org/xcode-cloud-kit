public protocol XcodeCloudKit {
}

struct DefaultXcodeCloudKit: XcodeCloudKit {
    private let transport: Transport
    
    init(transport: Transport) {
        self.transport = transport
    }
}
