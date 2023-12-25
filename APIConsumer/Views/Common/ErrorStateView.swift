//
//  ErrorStateView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI

struct ErrorStateView: View {
    let error: String
    var retryCallback: (() -> ())?
    var body: some View {
        HStack {
            Spacer()
            VStack (spacing: 16) {
                Text(error)
                if let retryCallback {
                    Button(action: retryCallback) {
                        Text("Retry")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
            Spacer()
        }
        .padding(64)
    }
}

#Preview("with Retry Button") {
    ErrorStateView(error: "An Error occured") {
        
    }
}

#Preview("without Retry Button") {
    ErrorStateView(error: "An Error occured")
}
