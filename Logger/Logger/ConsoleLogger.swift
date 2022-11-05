//
//  ConsoleLogger.swift
//  Logger
//
//  Created by jkucmin on 04/11/2022.
//

import os

class ConsoleLogger {
    static let shared = ConsoleLogger()
    
    private let logger: Logger
    
    init(logger: Logger = Logger()) {
        self.logger = logger
    }
    
    func log(_ message: Any..., type: OSLogType) {
        logger.log(level: type, "\(message)")
    }
    
    func log(_ error: Error) {
        logger.error("\(error)")
    }
}
