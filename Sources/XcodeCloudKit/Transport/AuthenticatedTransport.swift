protocol Transport {
    func perform<T: Decodable>(request: TransportRequest<T>) async throws -> T
}

struct TransportRequest<T: Decodable> {
    let path: String
    let method: String
    let queryParameters: [(key: String, value: String?)]?
}
