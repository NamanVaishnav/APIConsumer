//
//  APIConsumerApp.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI

@main
struct APIConsumerApp: App {
    
    @StateObject var appVM = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainListView()
        }
        .environmentObject(appVM)
    }
}
