public protocol XcodeCloudKit {
    func allProducts() async throws -> [Product]
}

final class DefaultXcodeCloudKit {
    private let transport: Transport
    
    init(transport: Transport) {
        self.transport = transport
    }
}

extension DefaultXcodeCloudKit: XcodeCloudKit {
    public func allProducts() async throws -> [Product] {
        let productResponse = try await transport.perform(request: RequestBuilder.products())
        
        let repositories: [(id: String, name: String)] = productResponse.included?.compactMap { includedItem in
            if case .scmRepository(let scmData) = includedItem, let name = scmData.attributes?.repositoryName {
                return (scmData.id, name)
            }
            
            return nil
        } ?? []
        
        return productResponse.data.compactMap { product in
            if let repository = repositories.first(where: { product.relationships?.primaryRepositories?.data?.first?.id == $0.id }),
               let name = product.attributes?.name {
                return Product(
                    name: name,
                    id: product.id,
                    repository: .init(id: repository.id, name: repository.name)
                )
            } else {
                return nil
            }
        }
    }
}
