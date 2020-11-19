//
//  Enums.swift
//  
//
//  Created by Erik Hatfield on 11/18/20.
//

import Fluent

//extension Todo {
//    enum Stat: String, Codable, CaseIterable {
//        static var name: FieldKey { .status }
//        case pending
//        case completed
//    }
//}
// allows us to store the status as an enum in the db
enum Status: String, Codable, CaseIterable {
    static var name: FieldKey { .status }
    
    case pending
    case completed
}
