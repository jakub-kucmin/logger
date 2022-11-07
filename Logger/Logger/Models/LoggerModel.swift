//
//  LoggerModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import CoreData

class LoggerModel {
    var date: Date
    var id: UUID
    var type: LoggerType
    var message: String
    var dateFormatter: DateFormatter
    var status: Int?
    var body: String?
    var method: String?
    var curl: String?
    var responseDate: Date?
    var responseBody: String?
    
    init(date: Date = Date(),
         id: UUID = UUID(),
         type: LoggerType,
         message: String,
         dateFormatter: DateFormatter = DateFormatter(),
         status: Int? = nil,
         body: String? = nil,
         method: String? = nil,
         curl: String? = nil,
         responseDate: Date? = nil,
         responseBody: String? = nil) {
        self.date = date
        self.id = id
        self.type = type
        self.message = message
        self.dateFormatter = dateFormatter
        self.status = status
        self.body = body
        self.method = method
        self.curl = curl
        self.responseDate = responseDate
        self.responseBody = responseBody
        dateFormatter.dateFormat = "MM.dd.yyyy, h:mm a"
    }
    
    init() {
        self.id = UUID()
        self.date = Date()
        self.message = ""
        self.type = .error
        self.status = nil
        self.body = nil
        self.method = nil
        self.curl = nil
        self.responseDate = nil
        self.responseBody = nil
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy, h:mm a"
    }
}

extension LoggerModel {
    convenience init?(cdLogger: CDLogger) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy, h:mm a"
        
        guard let id = cdLogger.id,
              let stringType = cdLogger.type,
              let type = LoggerType(rawValue: stringType),
              let message = cdLogger.message,
              let stringDate = cdLogger.date,
              let date = dateFormatter.date(from: stringDate) else {
            return nil
        }
                
        self.init(date: date,
                  id: id,
                  type: type,
                  message: message,
                  status: Int(cdLogger.status),
                  body: cdLogger.body,
                  method: cdLogger.method, curl: cdLogger.curl,
                  responseDate: cdLogger.responseDate,
                  responseBody: cdLogger.responseBody)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy, h:mm a"
        
        self.id = model.id
        self.message = model.message
        self.type = model.type.rawValue
        self.date = dateFormatter.string(from: model.date)
        self.curl = model.curl
        self.method = model.method
        self.body = model.body
        if let status = model.status {
            self.status = Int64(status)
        }
        self.responseDate = model.responseDate
        self.responseBody = model.responseBody
    }
}
