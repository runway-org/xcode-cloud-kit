import AppStoreConnect_Swift_SDK

extension RequestBuilder {
    struct WorkflowsResponse: Decodable {
        let data: [Data]
        
        struct Data: Decodable {
            let id: String
            let attributes: Attributes
            
            struct Attributes: Decodable {
                let name: String
            }
        }
    }
    
    static func allWorkflows(for productId: String) -> TransportRequest<WorkflowsResponse> {
        let allWorkflowsEndpoint = APIEndpoint
            .v1
            .ciProducts
            .id(productId)
            .workflows
        
        return .init(path: allWorkflowsEndpoint.path, method: "GET", queryParameters: [("fields[ciWorkflows]", "name")])
    }
    
    static func workflow(with id: String) -> TransportRequest<CiWorkflowResponse> {
        let workflow = APIEndpoint
            .v1
            .ciWorkflows
            .id(id)
            .get()
        
        return .init(path: workflow.path, method: workflow.method, queryParameters: workflow.query)
    }
}
