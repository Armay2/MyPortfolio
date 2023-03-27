//
//  Filter.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 27/03/2023.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var minModificationDate = Date.distantPast
    var tag: Tag?
    
    static var all = Filter(id: UUID(), name: "All Interests", icon: "tray")
    static var recent = Filter(id: UUID(), name: "Recent Interests", icon: "clock", minModificationDate: .now.addingTimeInterval(86400 * -7)) // Past 7 days
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
