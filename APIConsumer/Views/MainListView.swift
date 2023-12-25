//
//  ContentView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI
import TenttsAPI

struct MainListView: View {
    
    @EnvironmentObject var appVM:  AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    
    var body: some View {
        tickerListView
            .listStyle(.plain)
            .overlay {
                overlayView
            }
            .toolbar {
                titletoolBar
                attributionToolBar
            }
    }
    
    private var tickerListView: some View {
        List {
            ForEach(appVM.tickers) { ticker in
                TickerListRowView(data: .init(
                    symbol: ticker.symbol ?? "",
                    name: ticker.shortName,
                    price: quotesVM.priceForTicker(ticker),
                    type: .main))
                .contentShape(Rectangle())
                .onTapGesture { }
            }
            .onDelete{ appVM.removeTickers(atOffset: $0) }
        }
        
    }
    
    @ViewBuilder
    private var overlayView: some View {
        if appVM.tickers.isEmpty {
            EmptyStateView(text: appVM.emptyTickersText)
        }
    }
    
    
    private var titletoolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            VStack(alignment: .leading, spacing: -4) {
                Text(appVM.titleText)
                Text(appVM.subTitleText)
                    .foregroundStyle(Color.secondary)
            }.font(.title2.weight(.heavy))
                .padding(.bottom)
        }
    }
    private var attributionToolBar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack {
                Button(action: {
                    appVM.openYahooFinance()
                }, label: {
                    Text(appVM.attributionText)
                        .font(.caption.weight(.heavy))
                        .foregroundStyle(Color.secondary)
                })
                .buttonStyle(.plain)
                Spacer()
            }
        }
    }
}

#Preview ("With Tickers") {
    
    @StateObject var appVM : AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Ticker.stubs
        return vm
    }()

    @StateObject var quotesVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quoteDict = Quote.stubsDict
        return vm
    }()
    
    
    return Group {
        NavigationStack {
            MainListView(quotesVM: quotesVM)
        }
        .environmentObject(appVM)
    }
}

#Preview("With Empty Tickers") {
    @StateObject var emptyAppVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = []
        return vm
    }()
    
    @StateObject var quotesVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quoteDict = Quote.stubsDict
        return vm
    }()
    
    return NavigationStack {
        MainListView(quotesVM: quotesVM)
    }
    .environmentObject(emptyAppVM)
    
}
