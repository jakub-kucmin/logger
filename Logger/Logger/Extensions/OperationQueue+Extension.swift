//
//  OperationQueue+Extension.swift
//  Logger
//
//  Created by jkucmin on 08/11/2022.
//

import Foundation

extension OperationQueue {
    static let coredataSaveQueue = { () -> OperationQueue in
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
}
