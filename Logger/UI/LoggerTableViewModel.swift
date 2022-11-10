//
//  LoggerTableViewModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation

final class LoggerTableViewModel: ObservableObject {
    @Published var loggerModel: [LoggerModel]
        
    init(loggerModel: [LoggerModel] = []) {
        self.loggerModel = loggerModel
    }
    
    func getLogs() {
        loggerModel = FilmeoLogger.getLogs()
    }
    
    func deleteOldLoggs() {
        FilmeoLogger.deleteOldLogs()
    }
}
