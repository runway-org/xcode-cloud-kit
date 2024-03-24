import AppStoreConnect_Swift_SDK

public struct Workflow {
    public let id: String
    public let name: String
    public let product: Product
    
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
        guard let gitReferenceId = gitRefs.data
            .first(where: { xcGitRef in
                switch (gitReference, xcGitRef.attributes?.kind) {
                case (.branch(let name), .branch) where name == xcGitRef.attributes?.name: return true
                case (.tag(let name), .tag) where name == xcGitRef.attributes?.name: return true
                default: return false
                }
            })?.id else {
            return
        }
        
        let startWorkflowRequest = RequestBuilder.startWorkflow(withId: id, andGitReferenceId: gitReferenceId)
        _ = try await transport.perform(request: startWorkflowRequest)
    }
    
    private static func adapt(_ gitReference: GitReference) -> CiGitRefKind {
        switch gitReference {
        case .branch: return .branch
        case .tag: return .tag
        }
    }
}

// Add more cases to this enuk
public enum GitReference {
    case branch(name: String)
    case tag(name: String)
    
    var name: String {
        switch self {
        case let .branch(name): return name
        case let .tag(name): return name
        }
    }
}
