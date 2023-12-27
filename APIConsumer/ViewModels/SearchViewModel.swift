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
    
    var emptyStateListText: String{
        "Symbols not found for \n \"\(query)\""
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let stocksAPI: NetworkManager
    
    init(query: String = "", stocksAPI: NetworkManager = TenttsAPI()) {
        self.query = query
        self.stocksAPI = stocksAPI
        
        startObserving()
        
    }
    
    private func startObserving() {
        $query
            .debounce(for: 0.25, scheduler: DispatchQueue.main)
            .sink { _ in
                Task { [weak self] in await self?.searchTickers() }
            }
            .store(in: &cancellables)
        
        $query
            .filter { $0.isEmpty }
            .sink { [weak self] _ in self?.phase = .initial }
            .store(in: &cancellables)
    }
    
    func searchTickers() async {
        let searchQuery = trimmedQuery
        guard !searchQuery.isEmpty else { return }
        phase = .fetching
        
        do {
            let tickers = try await stocksAPI.searchTickers(query: searchQuery, isEquityTypeOnly: true)
            if searchQuery != trimmedQuery { return }
            if tickers.isEmpty {
                phase = .empty
            } else {
                phase = .success(tickers)
            }
        } catch {
            if searchQuery != trimmedQuery { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
