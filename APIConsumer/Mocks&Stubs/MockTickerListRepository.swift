//
//  MockTickerListRepository.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 28/12/23.
//

import Foundation
import TenttsAPI

#if DEBUG
struct MockTickerListRepository: TickerListRepository {
    
    
    func save(_ current: [Ticker]) async throws {
        
    }
    
    var stubbedLoad: (() async throws -> [Ticker])!
    func load() async throws -> [Ticker] {
        try await stubbedLoad()
    }
    
}

#endif
