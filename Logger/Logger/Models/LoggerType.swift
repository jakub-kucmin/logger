//
//  LoggerType.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

enum LoggerType: String {
    case error
    case info
    case debug
    case networking
    case keychain
    case userDefaults
    
    var color: Color {
        switch self {
        case .error:
            return Color.red
        case .info:
            return Color.blue
        case .debug:
            return Color.gray
        case .networking:
            return Color.purple
        case .keychain:
            return Color.yellow
        case .userDefaults:
            return Color.orange
        }
    }
}
