//
//  Quote+Extensions.swift
//  APIConsumer
//
//  Created by Naman Vaishnav on 25/12/23.
//

import Foundation
import TenttsAPI

extension Quote {
    var regularPriceText: String? {
        Utils.formate(value: regularMarketPrice)
    }
    
    var regularDiffText: String? {
        guard let text = Utils.formate(value: regularMarketChange) else { return nil }
        return text.hasPrefix("-") ? text : "+\(text)"
    }
    
    
}
