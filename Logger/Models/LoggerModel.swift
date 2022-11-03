//
//  LoggerModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import CoreData

struct LoggerModel {
    var date = Date()
    var id = UUID()
    var type: LoggerType
    var message: String
}

extension LoggerModel {
    init?(cdLogger: CDLogger) {
        guard let id = cdLogger.id,
              let stringType = cdLogger.type,
              let type = LoggerType(rawValue: stringType),
              let message = cdLogger.message,
              let date = cdLogger.date else {
            return nil
        }
        self.init(date: date, id: id, type: type, message: message)
    }
}

extension CDLogger {
    static func create(viewContext: NSManagedObjectContext) -> CDLogger? {
        guard let cdLogger = NSEntityDescription.insertNewObject(forEntityName: "CDLogger", into: viewContext) as? CDLogger else {
            return nil
        }
        return cdLogger
    }
    
    func update(from model: LoggerModel) {
        self.id = model.id
        self.date = model.date
        self.message = model.message
        self.type = model.type.rawValue
    }
}
