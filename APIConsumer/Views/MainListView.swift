//
//  ContentView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI
import TenttsAPI

struct MainListView: View {
    
    @EnvironmentObject var appVM:  AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    MainListView()
}
