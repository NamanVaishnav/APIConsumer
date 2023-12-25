//
//  EmptyStateView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI

struct EmptyStateView: View {
    
    let text: String
    var body: some View {
        HStack{
            Spacer()
            Text(text)
                .font(.headline)
                .foregroundStyle(Color.secondary)
            Spacer()
        }
        .padding(64)
        .lineLimit(3)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    EmptyStateView(text: "No data Availiable")
}
