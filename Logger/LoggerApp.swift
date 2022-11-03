//
//  LoggerApp.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

@main
struct LoggerApp: App {
    let persistenceController = PersistenceServiceImpl.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
