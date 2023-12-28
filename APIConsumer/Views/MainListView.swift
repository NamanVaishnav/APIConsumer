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
    @StateObject var searchVM = SearchViewModel()
    
    var body: some View {
        

            tickerListView
                .listStyle(.plain)
                .overlay { overlayView }
                .toolbar {
                    titletoolBar
                    attributionToolbar
            }

            .searchable(text: $searchVM.query)
            .refreshable {
                await quotesVM.fetchQuotes(tickers: appVM.tickers)
            }
            .task(id: appVM.tickers) {
                await quotesVM.fetchQuotes(tickers: appVM.tickers)
            }
    }
    
    private var tickerListView: some View {
        List {
            ForEach(appVM.tickers) { ticker in
                TickerListRowView(data: .init(
                    symbol: ticker.symbol,
                    name: ticker.shortname,
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
        
        if searchVM.isSearching {
            SearchView(searchVM: searchVM)
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
    private var attributionToolbar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack {
                Button {
                    appVM.openYahooFinance()
                } label: {
                    Text(appVM.attributionText)
                        .font(.caption.weight(.heavy))
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    @StateObject static var appVM : AppViewModel = {
//        let vm = AppViewModel()
//        vm.tickers = Ticker.stubs
//        return vm
        var mock = MockTickerListRepository()
        mock.stubbedLoad = { Ticker.stubs }
        return AppViewModel(repository: mock)
    }()
    
    @StateObject static var emptyAppVM: AppViewModel = {
//        let vm = AppViewModel()
//        vm.tickers = []
//        return vm
        
        var mock = MockTickerListRepository()
        mock.stubbedLoad = { [] }
        return AppViewModel(repository: mock)
    }()
    
    static var quotesVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quoteDict = Quote.stubsDict
        return vm
    }()
    
    static var searchVM: SearchViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedSearchedTickersCallback = { Ticker.stubs }
        return SearchViewModel(stocksAPI: mock)
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
                MainListView(quotesVM: quotesVM, searchVM : searchVM)
            }
            .environmentObject(appVM)
            .previewDisplayName("With Tickers")
            
            NavigationStack {
                MainListView(quotesVM: quotesVM ,searchVM: searchVM)
            }
            .environmentObject(emptyAppVM)
            .previewDisplayName("With Empty Tickers")
        }
    }
}

//#Preview ("With Tickers") {
//    
//    @StateObject var appVM : AppViewModel = {
//        let vm = AppViewModel()
//        vm.tickers = Ticker.stubs
//        return vm
//    }()
//
//    var quotesVM: QuotesViewModel = {
//        let vm = QuotesViewModel()
//        vm.quoteDict = Quote.stubsDict
//        return vm
//    }()
//    
//    var searchVM: SearchViewModel = {
//        let vm = SearchViewModel()
//        vm.phase = .success(Ticker.stubs)
//        return vm
//    }()
//    
//    
//    return Group {
//        NavigationStack {
//            MainListView(quotesVM: quotesVM, searchVM : searchVM)
//        }
//        .environmentObject(appVM)
//    }
//}
//
//#Preview("With Empty Tickers") {
//    @StateObject var emptyAppVM: AppViewModel = {
//        let vm = AppViewModel()
//        vm.tickers = []
//        return vm
//    }()
//    
//    var quotesVM: QuotesViewModel = {
//        let vm = QuotesViewModel()
//        vm.quoteDict = Quote.stubsDict
//        return vm
//    }()
//    
//    var searchVM: SearchViewModel = {
//        let vm = SearchViewModel()
//        vm.phase = .success(Ticker.stubs)
//        return vm
//    }()
//    
//    return NavigationStack {
//        MainListView(quotesVM: quotesVM ,searchVM: searchVM)
//    }
//    .environmentObject(emptyAppVM)
//    
//}
