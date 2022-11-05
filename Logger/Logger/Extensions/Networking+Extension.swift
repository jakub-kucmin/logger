//
//  File.swift
//  Logger
//
//  Created by jkucmin on 04/11/2022.
//

import Foundation

extension URLResponse {
    func getStatusCode() -> Int? {
        guard let response = self as? HTTPURLResponse else {
            return nil
        }
        return response.statusCode
    }
}

extension URLRequest {
    func getCurl() -> String? {
        guard let url = url?.absoluteString else {
            return nil
        }
        
        let baseCurl = "curl -X \(httpMethod ?? "") \(url)"
        var curlArray = [baseCurl]
        
        if httpMethod != "GET" {
            curlArray.append("-H \"Content-Type: application/json\"")
            
            if let body = httpBody,
               let stringBody = String(data: body, encoding: .utf8) {
                curlArray.append("-d \u{22}\(stringBody)\u{22}")
            }
        }
        
        return curlArray.joined(separator: " ")
    }
    
    func getQueryItems() -> [String: String?]? {
        guard let url = self.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.reduce(into: [String: String]()) { result, item in
            result[item.name] = item.value
        }
    }
}
