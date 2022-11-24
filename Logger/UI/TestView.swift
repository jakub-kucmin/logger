//
//  TestView.swift
//  Logger
//
//  Created by jkucmin on 03/11/2022.
//

import SwiftUI

struct TestView: View {
    @StateObject var viewModel: TestViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            buttons
            NavigationLink {
                LoggerTable(viewModel: LoggerTableViewModel())
            } label: {
                Text("Logs")
                    .foregroundColor(.green)
            }
            Button {
                viewModel.deleteLogs()
            } label: {
                Text("Delete logs")
                    .foregroundColor(.red)
            }
        }
    }
    
    var buttons: some View {
        VStack(spacing: 24) {
            Button {
                viewModel.saveInfoLog()
            } label: {
                Text("Create info log")
            }
            Button {
                viewModel.saveErrorLog()
            } label: {
                Text("Create error log")
            }
            Button {
                viewModel.saveDebugLog()
            } label: {
                Text("Create debug log")
            }
            Button {
                viewModel.get()
            } label: {
                Text("Create request log")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewModel: TestViewModel())
    }
}
