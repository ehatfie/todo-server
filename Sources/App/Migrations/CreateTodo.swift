import Fluent

struct CreateTodo: Migration {
    //var name: String { "custom-migration-name" } // unsure??
    
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        // used to migrate status values to an enum type in db??
//        var enumBuilder = database.enum(Status.name.description)
//        for option in Status.allCases {
//            enumBuilder = enumBuilder.case(option.rawValue)
//        }
//
//        return enumBuilder.create()
//            .flatMap { enumType in
//                database.schema(Todo.schema)
//                    .id()
//                    .field(.title, .string, .required)
//                    .field(.status, enumType, .required)
//                    .field(.labels, .int, .required)
//                    .field(.due, .datetime)
//                    .create()
//            }
//    }
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Todo.schema)
            .id()
            .field(.title, .string, .required)
            .field(.status, .string, .required)
            .field(.labels, .int, .required)
            .field(.due, .datetime)
            .create()
    }
    
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Todo.schema).delete()
    }

//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema(Todo.schema).delete().flatMap {
//            database.enum(Status.name.description).delete() // deleting enums??
//        }
//    }
}
