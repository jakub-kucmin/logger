//
//  LoggerTable.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

struct LoggerTable: View {
    @StateObject var viewModel: LoggerTableViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Text("LOGS")
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.loggerModel, id: \.id) { log in
                        NavigationLink {
                            LogDetails(viewModel: LogDetailsViewModel(loggerModel: log))
                        } label: {
                            Cell(loggerModel: log)
                                .padding(.vertical, 16)
                                .background(Color.white)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getLogs()
            }
        }
        .background(Color.gray)
    }
}

struct LoggerTable_Previews: PreviewProvider {
    static var previews: some View {
        LoggerTable(viewModel: LoggerTableViewModel())
    }
}
