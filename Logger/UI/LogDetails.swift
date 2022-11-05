//
//  LogDetails.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

struct LogDetails: View {
    var viewModel: LogDetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.loggerModel.responseBody ?? "")
        }
    }
}
