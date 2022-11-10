//
//  Persistence.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import CoreData

protocol PersistenceService {
    var backgroundContext: NSManagedObjectContext { get }
    var viewContext: NSManagedObjectContext { get }
    
    func saveContext()
}

struct PersistenceServiceImpl: PersistenceService {
    static let shared: PersistenceService = PersistenceServiceImpl()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return container.newBackgroundContext()
    }
    
    private let container: NSPersistentContainer
    
    private init() {
        container = DefaultPersistentContainer.getContainer()
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

final class DefaultPersistentContainer: NSObject {
    static func getContainer(for name: String = "Logger") -> NSPersistentContainer {
        guard let modelURL = Bundle(for: self).url(forResource: name, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            let container = NSPersistentContainer(name: name)
            return container
        }
        let container = NSPersistentContainer(name: name,
                                              managedObjectModel: managedObjectModel)
        return container
    }
}
