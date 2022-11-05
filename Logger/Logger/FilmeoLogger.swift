//
//  Logger.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation

class FilmeoLogger {
    static let shared = FilmeoLogger()
    
    private let loggerRepository: LoggerRepository
    private let consoleLogger: ConsoleLogger
    
    init(loggerRepository: LoggerRepository = LoggerRepositoryImpl.shared,
         consoleLogger: ConsoleLogger = .shared) {
        self.loggerRepository = loggerRepository
        self.consoleLogger = consoleLogger
    }
    
    func log(type: LoggerType, _ message: Any...) {
        let log = LoggerModel(type: type, message: "\(message)")
        loggerRepository.save(model: log)
        consoleLogger.log(message, type: .default)
    }
    
    func log(_ error: Error) {
        let log = LoggerModel(type: .error, message: "\(error)")
        loggerRepository.save(model: log)
        consoleLogger.log(error)
    }
    
    func getLogs() -> [LoggerModel] {
        return loggerRepository.fetch()
    }
    
    func getLog(id: UUID) -> LoggerModel? {
        return loggerRepository.fetch(id: id)
    }
    
    func deleteAllLogs() {
        loggerRepository.deleteAllLogs()
    }
}
