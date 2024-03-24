import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AnyEncodable: Encodable {
    private let value: Encodable

    init(_ value: Encodable) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

protocol Transport {
    func perform<T: Decodable>(request: TransportRequest<T>) async throws -> T
}

struct TransportRequest<T: Decodable> {
    let path: String
    let method: String
    let queryParameters: [(key: String, value: String?)]?
    let body: AnyEncodable?
    
    init(path: String, method: String, queryParameters: [(key: String, value: String?)]?, body: (AnyEncodable)? = nil) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.body = body
    }
}
