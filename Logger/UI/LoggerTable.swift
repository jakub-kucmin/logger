//
//  LoggerTable.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

struct LoggerTable: View {
    @StateObject var viewModel: LoggerTableViewModel
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View {
        VStack(spacing: 32) {
            Text("LOGS")
                .foregroundColor(foregroundColor)
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.loggerModel, id: \.id) { log in
                        NavigationLink {
                            LogDetails(viewModel: LogDetailsViewModel(loggerModel: log))
                        } label: {
                            Cell(loggerModel: log)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            .onAppear {
                viewModel.deleteOldLoggs()
                viewModel.getLogs()
            }
        }
        .background(backgroundColor)
    }
}

struct LoggerTable_Previews: PreviewProvider {
    static var previews: some View {
        LoggerTable(viewModel: LoggerTableViewModel(), backgroundColor: .white, foregroundColor: .black)
    }
}
