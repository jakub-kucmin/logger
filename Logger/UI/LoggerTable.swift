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
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                HeaderView(title: "LOGS")
                    .padding(.top, 16)
                logs
            }
            safeArea
        }
        .foregroundColor(.typo)
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            viewModel.deleteOldLoggs()
            viewModel.getLogs()
        }
    }
}

private extension LoggerTable {
    private var logs: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.loggerModel, id: \.id) { log in
                    NavigationLink {
                        LogDetails(viewModel: LogDetailsViewModel(loggerModel: log))
                    } label: {
                        Cell(loggerModel: log)
                            .background(Color.tag)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
    
    private var safeArea: some View {
        GeometryReader { proxy in
            Color.background
                .frame(height: proxy.safeAreaInsets.top, alignment: .top)
                .ignoresSafeArea()
        }
    }
}

struct LoggerTable_Previews: PreviewProvider {
    static var previews: some View {
        LoggerTable(viewModel: LoggerTableViewModel())
    }
}
