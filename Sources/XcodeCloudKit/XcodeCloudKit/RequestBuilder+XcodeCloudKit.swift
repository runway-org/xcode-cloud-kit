import AppStoreConnect_Swift_SDK

extension RequestBuilder {
    static func products() -> TransportRequest<CiProductsResponse> {
        let productsEndpoint = APIEndpoint
            .v1
            .ciProducts
            .get(parameters: .init(include: [.primaryRepositories]))
        
        return .init(path: productsEndpoint.path, method: productsEndpoint.method, queryParameters: productsEndpoint.query)
    }
}
