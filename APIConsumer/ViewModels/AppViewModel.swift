//
//  AppVIewModel.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import Foundation
import TenttsAPI
import SwiftUI

@MainActor
class AppViewModel: ObservableObject {
 
    @Published var tickers: [Ticker] = []
    
    
}


