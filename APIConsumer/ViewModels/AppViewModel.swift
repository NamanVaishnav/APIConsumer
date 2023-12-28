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
 
    @Published var tickers: [Ticker] = [] {
        didSet {
            saveTickers()
        }
    }
    var titleText = "API Consumer"
    
    @Published var subTitleText: String
    var emptyTickersText = "Search & add symbol to see stock quotes"
    var attributionText = "Powered by Yahoo! finance API"
    
    private let subtitleDateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "d MMM"
        return df
    }()
    
    let tickerListRepository: TickerListRepository
    
    
    init(repository: TickerListRepository = TickerPListRepository()){
        self.tickerListRepository = repository
        self.subTitleText = subtitleDateFormatter.string(from: Date())
        loadTickers()
    }
    
    private func loadTickers() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.tickers = try await tickerListRepository.load()
            } catch {
                print(error.localizedDescription)
                self.tickers = []
            }
            
        }
    }
    
    private func saveTickers() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                try await tickerListRepository.save(self.tickers)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func removeTickers(atOffset offset: IndexSet) {
        tickers.remove(atOffsets: offset)
        
    }
    
    func isAddedToMyTickers(ticker: Ticker) -> Bool {
        return tickers.first { $0.symbol == ticker.symbol } != nil
    }
    
    func toggleTicker(_ ticker: Ticker) {
        if isAddedToMyTickers(ticker: ticker) {
            removeFromMyTickers(ticker: ticker)
        } else {
            addToMyTickers(ticker: ticker)
        }
    }
    
    private func addToMyTickers(ticker: Ticker) {
        tickers.append(ticker)
    }
    
    private func removeFromMyTickers(ticker: Ticker) {
        guard let index = tickers.firstIndex(where: { $0.symbol == ticker.symbol }) else { return }
        tickers.remove(at: index)
    }
    
    func openYahooFinance() {
        
        guard let url = URL(string: "https://finance.yahoo.com"),    UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    
    
    
    
}


