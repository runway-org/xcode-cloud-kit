import AppStoreConnect_Swift_SDK

extension RequestBuilder {
    static func products() -> TransportRequest<CiProductsResponse> {
        let productsEndpoint = APIEndpoint
            .v1
            .ciProducts
            .get(parameters: .init(include: [.primaryRepositories]))
        
        return .init(path: productsEndpoint.path, method: productsEndpoint.method, queryParameters: productsEndpoint.query)
    }
    
    static func product(with id: String) -> TransportRequest<CiProductResponse> {
        let productEndpoint = APIEndpoint
            .v1
            .ciProducts
            .id(id)
            .get(parameters: .init(include: [.primaryRepositories]))
        
        return .init(path: productEndpoint.path, method: productEndpoint.method, queryParameters: productEndpoint.query)
    }
}
