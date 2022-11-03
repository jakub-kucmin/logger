//
//  LoggerRepository.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import CoreData

protocol LoggerRepository {
    func save(model: LoggerModel)
    func fetch() -> [LoggerModel]
    func fetch(id: UUID) -> LoggerModel?
}

struct LoggerRepositoryImpl: LoggerRepository {
    static let shared: LoggerRepository = LoggerRepositoryImpl()
    
    private let service: PersistenceService
    
    private init(service: PersistenceService = PersistenceServiceImpl.shared) {
        self.service = service
    }
    
    func save(model: LoggerModel) {
        if let cdLogger = CDLogger.create(viewContext: service.viewContext) {
            cdLogger.update(from: model)
            service.saveContext()
        }
    }
    
    func fetch() -> [LoggerModel] {
        let request = CDLogger.fetchRequest()
        var result: [CDLogger] = []
        
        do {
            try result = service.viewContext.fetch(request)
        } catch {
            return []
        }
        
        let loggs = result.compactMap { LoggerModel(cdLogger: $0) }
        
        return loggs
    }
    
    func fetch(id: UUID) -> LoggerModel? {
        let request = CDLogger.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(id)")
        let result: CDLogger?
        
        do {
            try result = service.viewContext.fetch(request).first
        } catch {
            return nil
        }
        
        guard let result = result else {
            return nil
        }
        
        let log = LoggerModel(cdLogger: result)
        return log
    }
}
