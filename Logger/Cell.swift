//
//  Cell.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

struct Cell: View {
    var loggerModel: LoggerModel
    
    var body: some View {
        HStack {
            Text(loggerModel.type.rawValue.capitalized)
            Spacer()
            Text("\(loggerModel.date)")
        }
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(loggerModel: .init(type: .error, message: "Test"))
    }
}
