//
//  Logger.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import OSLog

public final class FilmeoLogger {
    static let loggerRepository: LoggerRepository = LoggerRepositoryImpl.shared
    static let consoleLogger: ConsoleLogger = .shared
    
    public static func log(type: LoggerType, _ message: Any..., loggerPrivacy: LoggerPrivacyType = .private, category: String) {
        let log = LoggerModel(type: type, message: "\(message)")
        loggerRepository.save(model: log)
        consoleLogger.log(message, type: .default, loggerPrivacy: loggerPrivacy, category: category)
    }
    
    public static func log(_ error: Error, loggerPrivacy: LoggerPrivacyType = .private, category: String) {
        let log = LoggerModel(type: .error, message: "\(error)")
        loggerRepository.save(model: log)
        consoleLogger.log(error, loggerPrivacy: loggerPrivacy, category: category)
    }
    
    public static func getLogs() -> [LoggerModel] {
        return loggerRepository.fetch()
    }
    
    public static func getLog(id: UUID) -> LoggerModel? {
        return loggerRepository.fetch(id: id)
    }
    
    public static func deleteAllLogs() {
        loggerRepository.deleteAllLogs()
    }
    
    public static func deleteOldLogs() {
        loggerRepository.deleteOldLoggs()
    }
}
