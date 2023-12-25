//
//  LoadingStateView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        HStack{
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
    }
}

#Preview {
    LoadingStateView()
}
