import AppStoreConnect_Swift_SDK

class AppStoreConnectSDKTransport: Transport {
    private let appStoreConnectSDK: APIProvider
    
    init(appStoreConnectSDK: APIProvider) {
        self.appStoreConnectSDK = appStoreConnectSDK
    }
    
    func perform<T: Decodable>(request: TransportRequest<T>) async throws -> T {
        let request = Request<T>(
            path: request.path,
            method: request.method,
            query: request.queryParameters,
            body: request.body,
            id: ""
        )

        return try await appStoreConnectSDK.request(request)
    }
}
