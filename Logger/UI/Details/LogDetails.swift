//
//  LogDetails.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

struct LogDetails: View {
    @StateObject var viewModel: LogDetailsViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                HeaderView(title: "LOG DETAILS")
                    .padding(.top, 16)
                ScrollView {
                    logDetails
                }
            }
            safeArea
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.background)
        .foregroundColor(.typo)
        .ignoresSafeArea(edges: .bottom)
    }
}

private extension LogDetails {
    private var logDetails: some View {
        VStack(spacing: 24) {
            Text(viewModel.convertDateToString())
                .font(.system(size: 16))
            Text(viewModel.loggerModel.message.description)
                .font(.system(size: 13))
            Text(viewModel.loggerModel.body ?? "")
                .font(.system(size: 13))
            Text(viewModel.loggerModel.responseBody ?? "")
                .font(.system(size: 13))
        }
        .padding(.horizontal, 24)
    }
    
    private var safeArea: some View {
        GeometryReader { proxy in
            Color.background
                .frame(height: proxy.safeAreaInsets.top, alignment: .top)
                .ignoresSafeArea()
        }
    }
}
