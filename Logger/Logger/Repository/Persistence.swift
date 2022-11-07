//
//  Persistence.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import CoreData

protocol PersistenceService {
    var viewContext: NSManagedObjectContext { get }
    
    func saveContext()
}

struct PersistenceServiceImpl: PersistenceService {
    static let shared: PersistenceService = PersistenceServiceImpl()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    private let container: NSPersistentContainer
    
    private init(name: String = "Logger") {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error)
            }
            URLProtocol.registerClass(NetworkLogger.self)
        }
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            viewContext.performAndWait {
                do {
                    try viewContext.save()
                } catch {
                    viewContext.rollback()
                }
            }
        }
    }
}
