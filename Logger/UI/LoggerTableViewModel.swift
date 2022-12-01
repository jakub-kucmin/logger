//
//  LoggerTableViewModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation

open class LoggerTableViewModel: ObservableObject {
    @Published var loggerModel: [LoggerModel]
        
    public init(loggerModel: [LoggerModel] = []) {
        self.loggerModel = loggerModel
    }
    
    open func getLogs() {
        loggerModel = FilmeoLogger.getLogs()
    }
    
    open func deleteOldLoggs() {
        FilmeoLogger.deleteOldLogs()
    }
}
