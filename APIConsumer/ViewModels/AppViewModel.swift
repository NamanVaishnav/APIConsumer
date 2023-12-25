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
    var titleText = "API Consumer"
    
    @Published var subTitleText: String
    var emptyTickersText = "Search & add symbol to see stock quotes"
    var attributionText = "Powered by Yahoo! finance API"
    
    private let subtitleDateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "d MMM"
        return df
    }()
    
    init(){
        self.subTitleText = subtitleDateFormatter.string(from: Date())
    }
    
    func removeTickers(atOffset offset: IndexSet) {
        tickers.remove(atOffsets: offset)
        
    }
    
    func isAddedToMyTickers(ticker: Ticker) -> Bool {
        return tickers.first { $0.symbol == ticker.symbol } != nil
    }
    
    func toggleTicker(ticker: Ticker) {
        if isAddedToMyTickers(ticker: ticker) {
            
        } else {
            
        }
    }
    
    func openYahooFinance() {
        
        guard let url = URL(string: "https://finance.yahoo.com"),    UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    
    
    
    
}


