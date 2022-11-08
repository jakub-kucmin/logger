//
//  TestViewModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation
import Combine
import OSLog

final class TestViewModel: ObservableObject {
    
    private var subscriber: AnyCancellable?
    private let logger: FilmeoLogger
    
    init(logger: FilmeoLogger = .shared) {
        self.logger = logger
    }
    
    func saveInfoLog() {
        logger.log(type: .info, "INFO", category: LoggerType.info.rawValue)
    }
    
    func saveErrorLog() {
        logger.log(type: .error, "ERROR", category: LoggerType.error.rawValue)
    }
    
    func saveDebugLog() {
        logger.log(type: .debug, "DEBUG", category: LoggerType.debug.rawValue)
    }
    
    func saveNetworkLog() {
        logger.log(type: .networking, "REQUEST", category: LoggerType.networking.rawValue)
    }
    
    func deleteLogs() {
        logger.deleteAllLogs()
    }
    
    func get() {
        guard let url = URL(string: "https://catfact.ninja/fact") else {
            return
        }
        
        subscriber = URLSession.shared.dataTaskPublisher(for: url)
            .sink { completion in
                switch completion {
                case .finished:
                    self.logger.log(type: .info, "Finished fetching", category: LoggerType.info.rawValue)
                case .failure(let error):
                    self.logger.log(error, category: LoggerType.error.rawValue)
                }
            } receiveValue: { data, _ in
                print(data)
            }
    }
}
