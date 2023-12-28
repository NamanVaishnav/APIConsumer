//
//  QuotesViewModel.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import Foundation
import SwiftUI
import TenttsAPI

@MainActor
class QuotesViewModel: ObservableObject {
    @Published var quoteDict: [String: Quote] = [:]
    private let stocksAPI: NetworkManager
    
    init(stocksAPI: NetworkManager = TenttsAPI()) {
        self.stocksAPI = stocksAPI
    }
    
    func fetchQuotes(tickers: [Ticker]) async {
        guard !tickers.isEmpty else { return }
        do {
            let symbols = tickers.map { $0.symbol }.joined(separator: ",")
            let quotes = try await stocksAPI.fetchQuotes(symbols: symbols)
            var dict = [String : Quote]()
            quotes.forEach{ dict[$0.symbol] = $0 }
            self.quoteDict = dict
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func priceForTicker(_ ticker: Ticker) -> PriceChange? {
        guard let quote = quoteDict[ticker.symbol],
              let price = quote.regularPriceText,
              let change = quote.regularDiffText
        else { return nil }
        return (price, change)
    }
}

