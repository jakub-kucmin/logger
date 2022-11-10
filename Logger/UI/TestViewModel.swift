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
    
    func saveInfoLog() {
        FilmeoLogger.log(type: .info, "INFO", category: LoggerType.info.rawValue)
    }
    
    func saveErrorLog() {
        FilmeoLogger.log(type: .error, "ERROR", category: LoggerType.error.rawValue)
    }
    
    func saveDebugLog() {
        FilmeoLogger.log(type: .debug, "DEBUG", category: LoggerType.debug.rawValue)
    }
    
    func saveNetworkLog() {
        FilmeoLogger.log(type: .networking, "REQUEST", category: LoggerType.networking.rawValue)
    }
    
    func deleteLogs() {
        FilmeoLogger.deleteAllLogs()
    }
    
    func get() {
        guard let url = URL(string: "https://catfact.ninja/fact") else {
            return
        }
        
        subscriber = URLSession.shared.dataTaskPublisher(for: url)
            .sink { completion in
                switch completion {
                case .finished:
                    FilmeoLogger.log(type: .info, "Finished fetching", category: LoggerType.info.rawValue)
                case .failure(let error):
                    FilmeoLogger.log(error, category: LoggerType.error.rawValue)
                }
            } receiveValue: { data, _ in
                print(data)
            }
    }
}
