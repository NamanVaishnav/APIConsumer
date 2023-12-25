//
//  SearchViewModel.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import Foundation
import Combine
import SwiftUI
import TenttsAPI

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var query: String = ""
    @Published var phase: FetchPhase<[Ticker]> = .initial
    
    private var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var tickers: [Ticker] { phase.value ?? [] }
    var error: Error? { phase.error }
    var isSearching: Bool { !trimmedQuery.isEmpty }
    
    
    
}
