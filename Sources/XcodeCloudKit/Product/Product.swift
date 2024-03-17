public struct Product {
    public let name: String
    public let id: String
    public let repository: Repository
    let transport: Transport
    
    public struct Repository {
        public let id: String
        public let name: String
    }
    
    public func workflows() async throws -> [Workflow] {
        let allWorkflows = try await transport.perform(request: RequestBuilder.allWorkflows(for: id))
        
        return allWorkflows.data.map { Workflow(id: $0.id, name: $0.attributes.name, transport: transport) }
    }
    
    public func workflow(withId id: String) async throws -> Workflow {
        let workflow = try await transport.perform(request: RequestBuilder.workflow(with: id))
        
        return Workflow(id: workflow.data.id, name: workflow.data.attributes?.name ?? "", transport: transport)
    }
    
    public func workflow(withName name: String) async throws -> Workflow? {
        try await transport.perform(request: RequestBuilder.allWorkflows(for: id))
            .data
            .map { Workflow(id: $0.id, name: $0.attributes.name, transport: transport) }
            .first(where: { $0.name == name })
    }
}
