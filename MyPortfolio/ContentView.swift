//
//  ContentView.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 27/03/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        List(selection: $dataController.selectedInterest) {
            ForEach(dataController.interestsForSelectedFilter()) { interest in
                InterestRow(interest: interest)
            }.onDelete(perform: delete)
        }
        .navigationTitle("Interest")
        .searchable(text: $dataController.filterText, tokens: $dataController.filterTokens, suggestedTokens: .constant(dataController.suggestedFilterTokens), prompt: "Filter interest, or type # to add tags") { tag in
            Text(tag.tagName)        }
    }
    
    func delete(_ offsets: IndexSet) {
        let interests = dataController.interestsForSelectedFilter()
        
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
