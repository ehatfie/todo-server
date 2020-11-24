import Fluent
import Vapor

final class Todo: ApiModel, Content {
    
    struct _Input: Content {
        let title: String
        let status: Status
    }
    
    struct _Output: Content {
        let id: String
        let title: String
        let status: Status
    }
    
    typealias Input = _Input
    typealias Output = _Output
    
    static let schema = "todos"
    
    @ID() var id: UUID?
    @Field(key: .title) var title: String
    @Field(key: .status) var status: Status
    @Field(key: .labels) var labels: Labels
    @Field(key: .due) var due: Date?

    init() { }

    init(id: UUID? = nil, title: String, status: Status = .pending, labels: Labels = [], due: Date? = nil) {
        self.id = id
        self.title = title
        self.status = status
        self.labels = labels
        self.due = due
    }
    
    init(_ input: Input) throws {
            self.title = input.title
        }
        
        func update(_ input: Input) throws {
            self.title = input.title
        }
        
        var output: Output {
            .init(id: self.id!.uuidString, title: self.title, status: self.status)
        }
}
