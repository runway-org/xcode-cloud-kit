public struct Workflow {
    let id: String
    let name: String
    
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
                    startedAt: $0.attributes?.startedDate
                )
            }
    }
    
    public func build(with number: Int) async throws -> Build? {
        try await allBuilds().first(where: { $0.number == number })
    }
}
