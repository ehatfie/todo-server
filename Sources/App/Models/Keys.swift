//
//  Keys.swift
//  
//
//  Created by Erik Hatfield on 11/18/20.
//

import Fluent

// defines a key so we dont have to write out "title", "status, "labels", etc
extension FieldKey {
    static var title: Self { "title" }
    static var status: Self { "status" }
    static var labels: Self { "labels" }
    static var due: Self { "due" }
    static var name: Self { "name" }
}
