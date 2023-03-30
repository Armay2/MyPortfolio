//
//  Interest-CoreDataHelpers.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 27/03/2023.
//

import Foundation

extension Interest {
    var interestTitle: String {
        get { title ?? ""}
        set { title = newValue }
    }
    
    var interestContent: String {
        get { content ?? ""}
        set { content = newValue }
    }
    
    var interestCreationDate: Date {
        get { creationDate ?? .now}
    }
    
    var interestModificationDate: Date {
        get { modificationDate ?? .now}
    }
    
    var interestStatus: String {
        return isDoing ? "Currently doing" : "Not doing"
    }
    
    var interestTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }
    
    var interestTagList: String {
        guard let tags else {
            return "No tags"
        }
        
        if tags.count == 0 {
            return "No tags"
        } else {
            return interestTags.map(\.tagName).formatted()
        }
    }

    static var exemple: Interest {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let interest = Interest(context: viewContext)
        interest.title = "Exemple Title"
        interest.content = "This is an exemple interest"
        interest.priority = 2
        interest.creationDate = .now
        return interest
    }
}

extension Interest: Comparable {
    public static func <(lhs: Interest, rhs: Interest) -> Bool {
        let left = lhs.interestTitle.localizedLowercase
        let right = rhs.interestTitle.localizedLowercase
        
        if left == right {
            return lhs.interestCreationDate < rhs.interestCreationDate
        } else {
            return left < right
        }
        
    }
}


