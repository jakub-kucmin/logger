//
//  HeaderView.swift
//  Logger
//
//  Created by jkucmin on 24/11/2022.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String?
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.typo)
                }
                .padding(.leading, 24)
                HStack {
                    Spacer()
                    Text(title ?? "")
                    Spacer()
                }
            }
            Divider()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: nil)
    }
}
