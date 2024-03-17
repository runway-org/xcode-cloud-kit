public struct Workflow {
    let id: String
    let name: String
    let product: Product
    
    let transport: Transport
    
    public func allBuilds() async throws -> [Build] {
        let allBuilds = try await transport.perform(request: RequestBuilder.allBuilds(for: id))
        
        return allBuilds
            .data
            .map {
                Build(
                    number: $0.attributes?.number,
                    id: $0.id,
                    createdAt: $0.attributes?.createdDate,
                    endedAt: $0.attributes?.finishedDate,
                    startedAt: $0.attributes?.startedDate,
                    workflow: self
                )
            }
    }
    
    public func build(withNumber number: Int) async throws -> Build? {
        try await allBuilds().first(where: { $0.number == number })
    }
    
    public func start(atGitReference gitReference: GitReference) async throws {
        let gitRefsRequest = RequestBuilder.getGitReferences(forRepositoryId: product.repository.id)
        let gitRefs = try await transport.perform(request: gitRefsRequest)
        guard let gitReferenceId = gitRefs.data.first(where: { $0.attributes?.name == gitReference.name })?.id else {
            return
        }
        
        let startWorkflowRequest = RequestBuilder.startWorkflow(withId: id, andGitReferenceId: gitReferenceId)
        _ = try await transport.perform(request: startWorkflowRequest)
    }
}

// Add more cases to this enuk
public enum GitReference {
    case branch(name: String)
    
    var name: String {
        switch self {
        case let .branch(name): return name
        }
    }
}
