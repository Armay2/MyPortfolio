//
//  InterestRow.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 29/03/2023.
//

import SwiftUI

struct InterestRow: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var interest: Interest
    
    var body: some View {
        NavigationLink(value: interest) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                .opacity(interest.priority == 2 ? 1: 0)
                
                VStack(alignment: .leading) {
                    Text(interest.interestTitle)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(interest.interestTagList)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(interest.interestCreationDate.formatted(date: .numeric, time: .omitted))
                        .font(.subheadline)
                    
                    if interest.isDoing {
                        Text ("Doing" )
                        .font(.body.smallCaps())
                    }
                }.foregroundStyle(.secondary)
                // more code to come
            }
        }
    }
}

struct InterestRow_Previews: PreviewProvider {
    static var previews: some View {
        InterestRow(interest: Interest.exemple)
    }
}
