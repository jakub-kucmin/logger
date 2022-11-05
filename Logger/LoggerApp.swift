//
//  LoggerApp.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

@main
struct LoggerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TestView(viewModel: TestViewModel())
            }
        }
    }
}
