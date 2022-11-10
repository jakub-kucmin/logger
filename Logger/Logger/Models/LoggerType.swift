//
//  LoggerType.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

public enum LoggerType: String {
    case error
    case info
    case debug
    case networking
    
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
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .error:
            return UIColor.red
        case .info:
            return UIColor.blue
        case .debug:
            return UIColor.gray
        case .networking:
            return UIColor.purple
        }
    }
}
