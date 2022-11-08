//
//  LoggerTableViewModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation

final class LoggerTableViewModel: ObservableObject {
    @Published var loggerModel: [LoggerModel]
    
    private let logger: FilmeoLogger
    
    init(loggerModel: [LoggerModel] = [], logger: FilmeoLogger = .shared) {
        self.loggerModel = loggerModel
        self.logger = logger
    }
    
    func getLogs() {
        loggerModel = logger.getLogs()
    }
    
    func deleteOldLoggs() {
        logger.deleteOldLogs()
    }
}
