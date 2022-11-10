//
//  NetworkLogger.swift
//  Logger
//
//  Created by jkucmin on 04/11/2022.
//

import Foundation

final class NetworkLogger: URLProtocol {
    var model = NetworkLogModel()
    var response: URLResponse?
    var responseData: NSMutableData?
    var repository: LoggerRepository = LoggerRepositoryImpl.shared
    
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    override class func canInit(with request: URLRequest) -> Bool {
        return canServeRequest(request)
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        guard let request = task.currentRequest else {
            return false
        }
        return canServeRequest(request)
    }
    
    private class func canServeRequest(_ request: URLRequest) -> Bool {
        guard let url = request.url,
            (url.absoluteString.hasPrefix("http") || url.absoluteString.hasPrefix("https")) else {
                return false
        }
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        model.saveRequest(request)
        session.dataTask(with: request).resume()
    }
    
    override func stopLoading() {
        session.getTasksWithCompletionHandler { dataTask, _, _ in
            dataTask.forEach { $0.cancel() }
        }
    }
}

extension NetworkLogger: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData?.append(data)
        client?.urlProtocol(self, didLoad: data)
    }
    
    public func urlSession(_ session: URLSession,
                           dataTask: URLSessionDataTask,
                           didReceive response: URLResponse,
                           completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response
        self.responseData = NSMutableData()
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed
)
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocolDidFinishLoading(self)
        }
        
        guard let request = task.originalRequest else {
            return
        }
        
        model.saveRequestBody(request)
        
        if let error = error {
            saveError(error)
        } else if let response = response {
            saveResponse(response)
        }
    }
    
    func saveError(_ error: Error) {
        let log = LoggerModel()
        if let requestDate = model.requestDate {
            log.date = requestDate
        }
        log.responseDate = model.responseDate
        log.type = .error
        log.body = model.formattedRequestLog()
        log.responseBody = error.localizedDescription
        if let status = model.responseStatus {
            log.status = status
        }
        
        if let method = model.requestMethod {
            log.message = "[\(method)] \(model.requestUrl ?? "")"
        } else {
            log.message = model.requestUrl ?? ""
        }
        
        repository.save(model: log)
    }
    
    func saveResponse(_ response: URLResponse) {
        let data = (responseData ?? NSMutableData()) as Data
        model.saveResponse(response, data: data)
        let log = LoggerModel()
        if let requestDate = model.requestDate {
            log.date = requestDate
        }
        log.responseDate = model.responseDate
        log.body = model.formattedRequestLog()
        log.responseBody = model.formattedResponseLog()
        log.type = .networking
        
        if let status = model.responseStatus {
            log.status = status
        }
        
        if let method = model.requestMethod {
            log.message = "[\(method)] \(model.requestUrl ?? "")"
        } else {
            log.message = model.requestUrl ?? ""
        }
        
        repository.save(model: log)
    }
}
