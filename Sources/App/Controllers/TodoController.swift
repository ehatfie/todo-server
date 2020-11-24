import Fluent
import Vapor

struct TodoAPIModel: Content {
    let id: Todo.IDValue
    let title: String
    let completed: Bool
    
    init(data: Todo) {
        self.id = data.id!
        self.title = data.title
        self.completed = data.status == .completed
    }
}

struct TodoResponse: Content {
    let data: [TodoAPIModel]
    
    init(data: [Todo]) {
        self.data = data.map { return TodoAPIModel(data: $0) }
    }
}

struct TodoController: RouteCollection, ApiController {
    typealias Model = Todo
    
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":todoID") { todo in
            todo.delete(use: delete)
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture<TodoResponse> {
        return Todo.query(on: req.db).all().map { return TodoResponse(data: $0) }
    }
    
//    func create(req: Request) throws -> EventLoopFuture<Todo> {
//        let todo = try req.content.decode(Todo.self)
//        return todo.save(on: req.db).map { todo }
//    }
    
    /*
     curl -i -X POST "http://127.0.0.1:8080/todos" \
     -H "Content-Type: application/json" \
     -d '{"title": "Hello World!"}'
     */
    func create(req: Request) throws -> EventLoopFuture<Todo.Output> {
        let input = try req.content.decode(Todo.Input.self)
        let todo = Todo(title: input.title)
        return todo.save(on: req.db)
            .map { Todo.Output(id: todo.id!.uuidString, title: todo.title, status: todo.status) }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
