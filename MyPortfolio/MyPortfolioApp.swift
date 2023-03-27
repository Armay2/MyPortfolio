//
//  MyPortfolioApp.swift
//  MyPortfolio
//
//  Created by Arnaud NOMMAY on 27/03/2023.
//

import SwiftUI

@main
struct MyPortfolioApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
