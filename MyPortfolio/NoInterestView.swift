//
//  NoInterestView.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 29/03/2023.
//

import SwiftUI

struct NoInterestView: View {
    @EnvironmentObject var dataController: DataController
    
    
    var body: some View {
        Text("No Interest Selected")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New Interest") {
            // code
        }
    }
}

struct NoInterestView_Previews: PreviewProvider {
    static var previews: some View {
        NoInterestView()
    }
}
