//
//  SearchView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI
import TenttsAPI

struct SearchView: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @ObservedObject var searchVM: SearchViewModel
    
    var body: some View {
        List(searchVM.tickers) { ticker in
            TickerListRowView(data: .init(symbol: ticker.symbol ?? "",
                                          name: ticker.shortName,
                                          price: quotesVM.priceForTicker(ticker),
                                          type: .search(isSaved: appVM.isAddedToMyTickers(ticker: ticker), onButtonTapped: { appVM.toggleTicker(ticker) })))
            .contentShape(Rectangle())
            .onTapGesture { }
        }
        .listStyle(.plain)
        .overlay {
            listSearchOverLay
        }
    }
    
    @ViewBuilder
    private var listSearchOverLay: some View {
        switch searchVM.phase {
        
        case .fetching:
            LoadingStateView()
        
        case .failure(let error):
            ErrorStateView(error: error.localizedDescription) { 
                Task {
                    await searchVM.searchTickers()
                }
            }
        case .empty:
            EmptyStateView(text: searchVM.emptyStateListText)
            
        default: EmptyView()
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    
    @StateObject static var stubbedSearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    @StateObject static var emptySearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.query = "Theranos"
        vm.phase = .empty
        return vm
    }()
    
    @StateObject static var loadingSearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .fetching
        return vm
    }()
    
    @StateObject static var errorSearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .failure(NSError(domain: "", 
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey : "An error has been occured"]))
        
        return vm
    }()
    
    @StateObject static var appVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Array(Ticker.stubs.prefix(upTo: 2))
        return vm
    }()
    
    static var quotesVM : QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quoteDict = Quote.stubsDict
        return vm
    }()
    
    
    static var previews: some View {
        
        Group {
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: stubbedSearchVM)
            }
            .searchable(text: $stubbedSearchVM.query)
            .previewDisplayName("Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: emptySearchVM)
            }
            .searchable(text: $emptySearchVM.query)
            .previewDisplayName("Empty Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: loadingSearchVM)
            }
            .searchable(text: $loadingSearchVM.query)
            .previewDisplayName("Loading Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: errorSearchVM)
            }
            .searchable(text: $errorSearchVM.query)
            .previewDisplayName("Error Results")
        }
        .environmentObject(appVM)
    }
}
