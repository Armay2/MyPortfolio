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
            Text(tag.tagName)
        }
        .toolbar {
            Menu {
                Button (dataController.filterEnabled ? "Turn Filter Off": "Turn Filter On") {
                    dataController.filterEnabled.toggle()
                }
                Divider()
                
                Menu("Sort by") {
                    Picker("Sort by", selection: $dataController.sortType) {
                        Text ("Date Created" ).tag(SortType.dateCreated)
                        Text ("Date Modified" ).tag(SortType.dateModified)
                    }
                    
                    Divider()
                    
                    Picker ("Sort Order", selection: $dataController.sortNewestFirst) {
                        Text("New to Oldest").tag(true)
                        Text("Oldest to New").tag(false)
                    }
                }
                
                Picker("Satatus", selection: $dataController.filterStatus) {
                    Text("All").tag(Status.all)
                    Text("Doing").tag(Status.doing)
                    Text("Not Doing").tag(Status.notDoing)
                }
                .disabled(dataController.filterEnabled == false)
                
                Picker("Priority", selection: $dataController.filterPriority) {
                    Text("All").tag(-1)
                    Text("Low").tag(0)
                    Text("Medium").tag(1)
                    Text("High").tag(2)
                }
                .disabled(dataController.filterEnabled == false)

                
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    .symbolVariant(dataController.filterEnabled ? .fill : .none)
            }
        }
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
