//
//  InterestView.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 29/03/2023.
//

import SwiftUI

struct InterestView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var interest: Interest
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $interest.interestTitle, prompt: Text("Enter the interest title here"))
                        .font(.title)
                    
                    Text("**Modified:** \(interest.interestModificationDate.formatted (date: .long, time: .shortened))")
                        .foregroundStyle(.secondary)
                    
                    Text ("**Status:** \(interest.interestStatus)")
                        .foregroundStyle(.secondary)
                    
                }
                
                Picker("Priority", selection: $interest.priotity) {
                    Text ("Low").tag(Int16(0))
                    Text ("Medium").tag(Int16(1))
                    Text ("High" ).tag(Int16(2))
                }
                
                Menu {
                    // show selected tags first
                    ForEach(interest.interestTags) { tag in
                        Button {
                            interest.removeFromTags(tag)
                        } label: {
                            Label(tag.tagName, systemImage: "checkmark")
                        }
                    }

                    // now show unselected tags
                    let otherTags = dataController.missingTags(from: interest)

                    if otherTags.isEmpty == false {
                        Divider()

                        Section("Add Tags") {
                            ForEach(otherTags) { tag in
                                Button(tag.tagName) {
                                    interest.addToTags(tag)
                                }
                            }
                        }
                    }
                } label: {
                    Text(interest.interestTagList)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .animation(nil, value: interest.interestTagList)
                }

            }
            
            Section {
                VStack(alignment: .leading) {
                    Text("Basic Information")
                        .font (.title2)
                        .foregroundStyle(.secondary)
                    
                    TextField("Description", text: $interest.interestContent, prompt: Text("Enter the interest description here"), axis: .vertical)
                }
            }
        }
        .disabled(interest.isDeleted)
        .onReceive(interest.objectWillChange) { _ in
            dataController.queueSave()
        }
    }
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView(interest: Interest.exemple)
    }
}
