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
                .padding(.leading, 24)
            Spacer()
            Text(loggerModel.dateFormatter.string(from: loggerModel.date))
                .padding(.trailing, 24)
        }
        .foregroundColor(loggerModel.type.color)
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(loggerModel: .init(type: .error, message: "Test"))
    }
}
