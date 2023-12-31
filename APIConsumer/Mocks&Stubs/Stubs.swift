//
//  Stubs.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import Foundation
import TenttsAPI

#if DEBUG

extension Ticker {
    static var stubs: [Ticker] {
        [
            Ticker(symbol: "AAPL", shortname: "Apple Inc."),
            Ticker(symbol: "TSLA", shortname: "Tesla."),
            Ticker(symbol: "NVDA", shortname: "Nvidia Corp."),
            Ticker(symbol: "AMD", shortname: "Advanced Micro Device")
        ]
    }
}

extension Quote {
    static var stubs: [Quote] {
        [
            Quote(symbol: "AAPL", regularMarketPrice: 150.43, regularMarketChange: -2.31),
            Quote(symbol: "TSLA", regularMarketPrice: 250.43, regularMarketChange: 2.89),
            Quote(symbol: "NVDA", regularMarketPrice: 100.43, regularMarketChange: -19.32),
            Quote(symbol: "AMD", regularMarketPrice: 70.43, regularMarketChange: 12.55)
            
        ]
    }
    
    static var stubsDict: [String: Quote] {
        var dict = [String : Quote]()
        stubs.forEach { dict[$0.symbol ?? "AAPL"] = $0 }
        return dict
    }
}

#endif
