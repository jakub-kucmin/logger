//
//  Logger.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation

class Logger {
    static let shared = Logger()
    
    private let loggerRepository: LoggerRepository
    
    init(loggerRepository: LoggerRepository = LoggerRepositoryImpl.shared) {
        self.loggerRepository = loggerRepository
    }
    
    func log(type: LoggerType, _ message: String) {
        let log = LoggerModel(type: type, message: message)
        loggerRepository.save(model: log)
    }
    
    func log(_ error: Error) {
        let log = LoggerModel(type: .error, message: "\(error)")
        loggerRepository.save(model: log)
    }
}
