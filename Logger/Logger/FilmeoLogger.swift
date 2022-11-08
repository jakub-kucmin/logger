//
//  Logger.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import OSLog

public final class FilmeoLogger {
    static let shared = FilmeoLogger()
    
    private let loggerRepository: LoggerRepository
    private let consoleLogger: ConsoleLogger
        
   private init(loggerRepository: LoggerRepository = LoggerRepositoryImpl.shared,
         consoleLogger: ConsoleLogger = .shared) {
        self.loggerRepository = loggerRepository
        self.consoleLogger = consoleLogger
    }
    
    public func log(type: LoggerType, _ message: Any..., loggerPrivacy: LoggerPrivacyType = .private, category: String) {
        let log = LoggerModel(type: type, message: "\(message)")
        loggerRepository.save(model: log)
        consoleLogger.log(message, type: .default, loggerPrivacy: loggerPrivacy, category: category)
    }
    
    public func log(_ error: Error, loggerPrivacy: LoggerPrivacyType = .private, category: String) {
        let log = LoggerModel(type: .error, message: "\(error)")
        loggerRepository.save(model: log)
        consoleLogger.log(error, loggerPrivacy: loggerPrivacy, category: category)
    }
    
    public func getLogs() -> [LoggerModel] {
        return loggerRepository.fetch()
    }
    
    public func getLog(id: UUID) -> LoggerModel? {
        return loggerRepository.fetch(id: id)
    }
    
    public func deleteAllLogs() {
        loggerRepository.deleteAllLogs()
    }
    
    public func deleteOldLogs() {
        loggerRepository.deleteOldLoggs()
    }
}
