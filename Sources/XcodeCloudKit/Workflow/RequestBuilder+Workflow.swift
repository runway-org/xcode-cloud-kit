import AppStoreConnect_Swift_SDK

extension RequestBuilder {
    static func allBuilds(for workflowId: String) -> TransportRequest<CiBuildRunsResponse> {
        let endpoint = APIEndpoint
            .v1
            .ciWorkflows
            .id(workflowId)
            .buildRuns
            .get()
        
        return .init(path: endpoint.path, method: endpoint.method, queryParameters: endpoint.query)
    }
    
    static func startWorkflow(withId id: String, andGitReferenceId gitReferenceId: String) -> TransportRequest<CiBuildRunResponse> {
        let requestRelationships = CiBuildRunCreateRequest
            .Data
            .Relationships(
                workflow: .init(data: .init(type: .ciWorkflows, id: id)),
                sourceBranchOrTag: .init(data: .init(type: .scmGitReferences, id: gitReferenceId))
            )
        
         let requestData = CiBuildRunCreateRequest.Data(
             type: .ciBuildRuns,
             relationships: requestRelationships
         )

        let buildRunCreateRequest = CiBuildRunCreateRequest(data: requestData)

        let workflowRun = APIEndpoint
            .v1
            .ciBuildRuns
            .post(buildRunCreateRequest)
        
        return .init(path: workflowRun.path, method: workflowRun.method, queryParameters: workflowRun.query)
    }
    
    static func getGitReferences(forRepositoryId repositoryId: String) -> TransportRequest<ScmGitReferencesResponse> {
        let gitRefsEndpoint = APIEndpoint
             .v1
             .scmRepositories
             .id(repositoryId)
             .gitReferences
             .get()
        
        return .init(path: gitRefsEndpoint.path, method: gitRefsEndpoint.method, queryParameters: gitRefsEndpoint.query)
    }
}
