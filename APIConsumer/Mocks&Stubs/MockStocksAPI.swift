//
//  MockStocksAPI.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 26/12/23.
//

import Foundation
import TenttsAPI

#if DEBUG

struct MockStocksAPI: NetworkManager {
    
    var stubbedSearchedTickersCallback: (() async throws -> [Ticker])!
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker] {
        try await stubbedSearchedTickersCallback()
    }
    
    var stubbedFetchQuotesCallback: (() async throws -> [Quote])!
    func fetchQuotes(symbols: String) async throws -> [Quote] {
        try await stubbedFetchQuotesCallback()
    }
    
    
}

#endif
