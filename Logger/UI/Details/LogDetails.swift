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
        ScrollView {
            if viewModel.loggerModel.type == .networking {
                networkingLogDetails
            } else {
                logDetails
            }
        }
    }
}

private extension LogDetails {
    private var logDetails: some View {
        VStack {
            Text(viewModel.convertDateToString())
            Text(viewModel.loggerModel.message)
        }
        .padding(.horizontal, 24)
    }
    
    private var networkingLogDetails: some View {
        VStack(spacing: 24) {
            Text(viewModel.loggerModel.body ?? "")
                .font(.system(size: 13))
            Text(viewModel.loggerModel.responseBody ?? "")
                .font(.system(size: 13))
        }
        .padding(.horizontal, 24)
    }
}
