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
}
