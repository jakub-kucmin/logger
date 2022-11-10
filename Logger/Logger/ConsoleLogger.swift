//
//  ConsoleLogger.swift
//  Logger
//
//  Created by jkucmin on 04/11/2022.
//

import OSLog

final class ConsoleLogger {
    static let shared = ConsoleLogger()
    
    private let logger: Logger
    
    private init(logger: Logger = Logger()) {
        self.logger = logger
    }
    
    func log(_ message: Any..., type: OSLogType, loggerPrivacy: LoggerPrivacyType, category: String) {
        switch loggerPrivacy {
        case .private:
            logger.log(level: type, "\(message, privacy: .private)")
        case .public:
            logger.log(level: type, "\(message, privacy: .public)")
        case .sensitive:
            logger.log(level: type, "\(message, privacy: .sensitive)")
        case .auto:
            logger.log(level: type, "\(message, privacy: .auto)")
        }
    }
    
    func log(_ error: Error, loggerPrivacy: LoggerPrivacyType, category: String) {
        switch loggerPrivacy {
        case .private:
            logger.error("\(error, privacy: .private)")
        case .public:
            logger.error("\(error, privacy: .public)")
        case .sensitive:
            logger.error("\(error, privacy: .sensitive)")
        case .auto:
            logger.error("\(error, privacy: .auto)")
        }
    }
}
