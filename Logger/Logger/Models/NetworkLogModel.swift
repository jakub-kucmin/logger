//
//  NetworkLogModel.swift
//  Logger
//
//  Created by jkucmin on 04/11/2022.
//

import Foundation

struct NetworkLogModel {
    var requestUrl: String?
    var requestMethod: String?
    var requestDate: Date?
    var requestCurl: String?
    var requestData: Data?
    var queryItems: [String: String?]?
    
    var responseDate: Date?
    var responseData: Data?
    var responseStatus: Int?
    
    mutating func saveRequest(_ request: URLRequest) {
        self.requestUrl = request.url?.absoluteString
        self.requestMethod = request.httpMethod
        self.requestDate = Date()
        self.requestCurl = request.getCurl()
        self.queryItems = request.getQueryItems()
    }
    
    mutating func saveRequestBody(_ request: URLRequest) {
        self.requestData = request.httpBody
    }
    
    mutating func saveResponse(_ response: URLResponse, data: Data) {
        self.responseDate = Date()
        self.responseData = data
        self.responseStatus = response.getStatusCode()
    }
    
    func formattedRequestLog() -> String {
        var log = String()
        
        if let requestUrl = requestUrl {
            log.append("------START REQUEST - \(requestUrl)------\n")
        }
        
        if let curl = requestCurl {
            log.append("[REQUEST CURL] \(curl)\n")
        }
        
        if let method = requestMethod {
            log.append("[REQUEST METHOD] \(method)\n")
        }
        
        if let requestDate = requestDate {
            log.append("[REQUEST DATE] \(requestDate)\n")
        }
        
        if let queryItems = queryItems {
            log.append("[QUERY ITEMS]\n{\n")
            queryItems.forEach { items in
                if let value = items.value {
                    log.append("\t\"\(items.key)\": \(value)\n")
                }
            }
            log.append("}\n")
        }
        
        log.append("[REQUEST BODY]\n\(getRequestBody())\n")
        
        if let requestUrl = requestUrl {
            log.append("------END REQUEST - \(requestUrl)------\n")
        }
        
        return log
    }
    
    func formattedResponseLog() -> String {
        var log = String()
        
        if let requestUrl = requestUrl {
            log.append("------START RESPONSE - \(requestUrl)------\n")
        }
        
        if let responseDate = responseDate {
            log.append("[RESPONSE DATE] \(responseDate)\n")
        }
        
        if let statusCode = responseStatus {
            log.append("[RESPONSE CODE] \(statusCode)\n")
        }
        
        log.append("[RESPONSE BODY]\n\(getResponseBody())\n")
        
        if let requestUrl = requestUrl {
            log.append("------END RESPONSE - \(requestUrl)------\n")
        }

        return log
    }
    
    func getRequestBody() -> NSString {
        guard let data = self.requestData else {
            return ""
        }
        return prettyOutput(data)
    }
    
    func getResponseBody() -> NSString {
        guard let data = self.responseData else {
            return ""
        }
        return prettyOutput(data)
    }
    
    private func prettyPrint(_ rawData: Data) -> NSString? {
        do {
            let rawJsonData = try JSONSerialization.jsonObject(with: rawData, options: [])
            let prettyPrintedString = try JSONSerialization.data(withJSONObject: rawJsonData, options: [.prettyPrinted])
            return NSString(data: prettyPrintedString, encoding: String.Encoding.utf8.rawValue)
        } catch {
            return nil
        }
    }
    
    private func prettyOutput(_ rawData: Data, contentType: String? = nil) -> NSString {
        if let output = prettyPrint(rawData) {
            return output as NSString
        }
        return NSString(data: rawData, encoding: String.Encoding.utf8.rawValue) ?? ""
    }
}
