//
//  Utils.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import Foundation

struct Utils {
    static let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    static func formate(value: Double?) -> String? {
        guard let value, 
              let text = numberFormatter.string(from: NSNumber(value: value))
        else { return nil}
        return text
    }
}
