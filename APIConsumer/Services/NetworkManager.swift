//
//  NetworkManager.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 26/12/23.
//

import Foundation
import TenttsAPI


protocol NetworkManager {
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker]
    func fetchQuotes(symbols: String) async throws -> [Quote]
}

extension TenttsAPI: NetworkManager {
    
}
