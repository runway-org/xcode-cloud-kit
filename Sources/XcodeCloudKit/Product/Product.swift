public struct Product {
    public let name: String
    public let id: String
    public let repository: Repository
    let transport: Transport
    
    public struct Repository {
        public let id: String
        public let name: String
    }
}
