//
//  LogDetailsViewModel.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import Foundation
 
open class LogDetailsViewModel: ObservableObject {
    @Published var loggerModel: LoggerModel
    
    private let dateFormatter: DateFormatter
    
    public init(loggerModel: LoggerModel, dateFormatter: DateFormatter = DateFormatter()) {
        self.loggerModel = loggerModel
        self.dateFormatter = dateFormatter
        dateFormatter.dateFormat = "MM.dd.yyyy, h:mm a"
    }
    
    open func convertDateToString() -> String {
        return dateFormatter.string(from: loggerModel.date)
    }
}
