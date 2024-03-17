import Foundation

public struct Build {
    let number: Int?
    let id: String
    let createdAt: Date?
    let endedAt: Date?
    let startedAt: Date?
    let workflow: Workflow
}
