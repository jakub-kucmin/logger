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
            Rectangle()
                .frame(width: 4)
                .frame(maxHeight: .infinity)
                .foregroundColor(loggerModel.type.color)
            Text(loggerModel.type.rawValue.capitalized)
                .padding(.leading, 24)
                .foregroundColor(loggerModel.type.color)
            Spacer()
            Text(loggerModel.getDate())
                .padding(.trailing, 24)
                .foregroundColor(Color.black)
        }
        .frame(height: 50)
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(loggerModel: .init(type: .error, message: "Test"))
    }
}
