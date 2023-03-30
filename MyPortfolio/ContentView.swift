//
//  ContentView.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 27/03/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    var interests: [Interest] {
        let filter = dataController.selectedFilter ?? .all
        var allInterest: [Interest]
        
        if let tag = filter.tag {
            allInterest = tag.interests?.allObjects as? [Interest] ?? []
        } else {
            let request = Interest.fetchRequest()
            request.predicate = NSPredicate(format: "modificationDate > %@", filter.minModificationDate as NSDate)
            allInterest = (try? dataController.container.viewContext.fetch(request)) ?? []
        }
        return allInterest.sorted()
    }
    
    var body: some View {
        List(selection: $dataController.selectedInterest) {
            ForEach(interests) { interest in
                InterestRow(interest: interest)
            }.onDelete(perform: delete)
        }
    }
    
    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let item = interests[offset]
            dataController.delete(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
