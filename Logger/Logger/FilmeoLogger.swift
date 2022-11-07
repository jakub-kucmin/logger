//
//  Logger.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation
import OSLog

class FilmeoLogger {
    static let shared = FilmeoLogger()
    
    private let loggerRepository: LoggerRepository
    private let consoleLogger: ConsoleLogger
        
    init(loggerRepository: LoggerRepository = LoggerRepositoryImpl.shared,
         consoleLogger: ConsoleLogger = .shared) {
        self.loggerRepository = loggerRepository
        self.consoleLogger = consoleLogger
    }
    
    func log(type: LoggerType, _ message: Any..., loggerPrivacy: LoggerPrivacyType = .private, category: String) {
        let log = LoggerModel(type: type, message: "\(message)")
        loggerRepository.save(model: log)
        consoleLogger.log(message, type: .default, loggerPrivacy: loggerPrivacy, category: category)
    }
    
    func log(_ error: Error, loggerPrivacy: LoggerPrivacyType = .private, category: String) {
        let log = LoggerModel(type: .error, message: "\(error)")
        loggerRepository.save(model: log)
        consoleLogger.log(error, loggerPrivacy: loggerPrivacy, category: category)
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
