//
//  TickerListRowView.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import SwiftUI

struct TickerListRowView: View {
    
    
    
    let data: TickerListRawData
    
    var body: some View {
        HStack(alignment: .center, content: {
            if case let .search(isSaved, onButtonTapped) = data.type {
                Button {
                    onButtonTapped()
                } label: {
                    image(isSaved: isSaved)
                }

            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(data.symbol)
                    .font(.headline.bold())
                if let name = data.name {
                    Text(name)
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                }
            }
            
            Spacer()
            
            if let (price, change) = data.price {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(price)
                    priceChangeView(text: change)
                }
                .font(.headline.bold())
            }
        })
        
    }
    
    @ViewBuilder
    func image(isSaved: Bool) -> some View {
        if isSaved {
            Image(systemName: "checkmark.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.white, Color.accentColor)
                .imageScale(.large)
        } else {
            Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.accentColor, Color.secondary.opacity(0.3))
                .imageScale(.large)
        }
    }
    
    @ViewBuilder
    func priceChangeView(text: String) -> some View {
        if case .main = data.type {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(text.hasPrefix("-") ? .red : .green)
                    .frame(height: 24)
                Text(text)
                    .foregroundStyle(Color.white)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
            }
            .fixedSize()
        } else {
            Text(text)
                .foregroundStyle(text.hasPrefix("-") ? .red : .green)
        }
    }
}

#Preview ("main plus") {
    TickerListRowView(data: TickerListRawData(symbol: "AAPL", name: "Apple Inc.", price: ("100.0", "+0.7"), type: .main))
    
}

#Preview ("main minus") {
    TickerListRowView(data: TickerListRawData(symbol: "AAPL", name: "Apple Inc.", price: ("100.0", "-0.7"), type: .main))
    
}

#Preview ("Search Saved") {
    TickerListRowView(data: TickerListRawData(symbol: "AAPL", name: "Apple Inc.", price: ("100.0", "+0.7"), type: .search(isSaved: true, onButtonTapped: {})))
    
}

#Preview ("Search Note Saved") {
    TickerListRowView(data: TickerListRawData(symbol: "AAPL", name: "Apple Inc.", price: ("100.0", "-0.7"), type: .search(isSaved: false, onButtonTapped: {})))
    
}



