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
    
    func priceForTicker(_ ticker: Ticker) -> PriceChange? {
        guard let symbol = ticker.symbol,
                let quote = quoteDict[symbol],
              let price = quote.regularPriceText,
              let change = quote.regularDiffText
        else { return nil }
        return (price, change)
    }
}

