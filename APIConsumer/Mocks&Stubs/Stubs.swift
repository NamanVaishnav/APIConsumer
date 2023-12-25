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
            Ticker(symbol: "AAPL", quoteType: nil, shortName: "Apple Inc.", longName: nil, sector: nil, industry: nil, exchDisp: nil),
            
            Ticker(symbol: "TSLA", quoteType: nil, shortName: "Tesla.", longName: nil, sector: nil, industry: nil, exchDisp: nil),
            
            Ticker(symbol: "NVDA", quoteType: nil, shortName: "Nvidia Corp.", longName: nil, sector: nil, industry: nil, exchDisp: nil),
            
            Ticker(symbol: "AMD", quoteType: nil, shortName: "Advanced Micro Devices", longName: nil, sector: nil, industry: nil, exchDisp: nil),
        ]
    }
}

extension Quote {
    static var stubs: [Quote] {
        [
            Quote(currency: nil, marketState: nil, fullExchangeName: nil, displayName: nil, symbol: "AAPL", regularMarketPrice: 150.5, regularMarketChange: -2.31, regularMarketChangePercent: nil, regularMarketChangePreviousClose: nil, postMarketPrice: nil, postMarketPriceChange: nil, regularMarketOpen: nil, regularMarketDayHigh: nil, regularMarketDayLow: nil, regularMarketVolume: nil, trailingPE: nil, marketCap: nil, fiftyTwoWeekLow: nil, fiftyTwoWeekHigh: nil, averageDailyVolume3Month: nil, trailingAnnualDividendYield: nil, epsTrailingTwelveMonths: nil),
            
            Quote(currency: nil, marketState: nil, fullExchangeName: nil, displayName: nil, symbol: "TSLA", regularMarketPrice: 250.5, regularMarketChange: 2.31, regularMarketChangePercent: nil, regularMarketChangePreviousClose: nil, postMarketPrice: nil, postMarketPriceChange: nil, regularMarketOpen: nil, regularMarketDayHigh: nil, regularMarketDayLow: nil, regularMarketVolume: nil, trailingPE: nil, marketCap: nil, fiftyTwoWeekLow: nil, fiftyTwoWeekHigh: nil, averageDailyVolume3Month: nil, trailingAnnualDividendYield: nil, epsTrailingTwelveMonths: nil),
            
            Quote(currency: nil, marketState: nil, fullExchangeName: nil, displayName: nil, symbol: "NVDA", regularMarketPrice: 100.5, regularMarketChange: -9.31, regularMarketChangePercent: nil, regularMarketChangePreviousClose: nil, postMarketPrice: nil, postMarketPriceChange: nil, regularMarketOpen: nil, regularMarketDayHigh: nil, regularMarketDayLow: nil, regularMarketVolume: nil, trailingPE: nil, marketCap: nil, fiftyTwoWeekLow: nil, fiftyTwoWeekHigh: nil, averageDailyVolume3Month: nil, trailingAnnualDividendYield: nil, epsTrailingTwelveMonths: nil),
            
            
            Quote(currency: nil, marketState: nil, fullExchangeName: nil, displayName: nil, symbol: "AMD", regularMarketPrice: 70.5, regularMarketChange: -2.31, regularMarketChangePercent: nil, regularMarketChangePreviousClose: nil, postMarketPrice: nil, postMarketPriceChange: nil, regularMarketOpen: nil, regularMarketDayHigh: nil, regularMarketDayLow: nil, regularMarketVolume: nil, trailingPE: nil, marketCap: nil, fiftyTwoWeekLow: nil, fiftyTwoWeekHigh: nil, averageDailyVolume3Month: nil, trailingAnnualDividendYield: nil, epsTrailingTwelveMonths: nil),
            
        ]
    }
    
    static var stubsDict: [String: Quote] {
        var dict = [String : Quote]()
        stubs.forEach { dict[$0.symbol ?? "AAPL"] = $0 }
        return dict
    }
}

#endif
