//
//  Labels.swift
//  
//
//  Created by Erik Hatfield on 11/18/20.
//

import Fluent

struct Labels: OptionSet, Codable {
    var rawValue: Int
    
    static let red = Labels(rawValue: 1 << 0)
    static let purple = Labels(rawValue: 1 << 1)
    static let orange = Labels(rawValue: 1 << 2)
    static let yellow = Labels(rawValue: 1 << 3)
    static let green = Labels(rawValue: 1 << 4)
    static let blue = Labels(rawValue: 1 << 5)
    static let gray = Labels(rawValue: 1 << 6)
    static let all: Labels = [.red, .purple, .orange, .yellow, .green, .blue, .gray]
}
