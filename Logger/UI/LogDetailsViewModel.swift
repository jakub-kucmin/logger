//
//  LogDetailsViewModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation
 
final class LogDetailsViewModel: ObservableObject {
    @Published var loggerModel: LoggerModel
    
    init(loggerModel: LoggerModel) {
        self.loggerModel = loggerModel
    }
}
