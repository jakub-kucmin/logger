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
    func deleteAllLogs()
    func deleteOldLoggs()
}

struct LoggerRepositoryImpl: LoggerRepository {
    static let shared: LoggerRepository = LoggerRepositoryImpl()
    static let logExpiration = -48
    
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
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        var result: [CDLogger]
        request.sortDescriptors = [sortDescriptor]
        
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
    
    func deleteAllLogs() {
        let request = CDLogger.fetchRequest()
        var logs: [CDLogger]
        
        do {
            try logs = service.viewContext.fetch(request)
            logs.forEach { service.viewContext.delete($0) }
        } catch {
            return
        }
        service.saveContext()
    }
    
    func deleteOldLoggs() {
        guard let oldDate = Calendar.current.date(byAdding: .hour,
                                                  value: LoggerRepositoryImpl.logExpiration,
                                                  to: Date()) else {
            return
        }
        OperationQueue.coredataSaveQueue.isSuspended = true
        OperationQueue.coredataSaveQueue.cancelAllOperations()
        let request: NSFetchRequest<NSFetchRequestResult> = CDLogger.fetchRequest()
        request.predicate = NSPredicate(format: "date < %@", oldDate as NSDate)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try service.backgroundContext.execute(deleteRequest)
        } catch { }
        
        OperationQueue.coredataSaveQueue.isSuspended = false
    }
}
