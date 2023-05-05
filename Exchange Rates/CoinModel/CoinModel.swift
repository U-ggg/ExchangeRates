//
//  CoinModel.swift
//  Exchange Rates
//
//  Created by sidzhe on 01.05.2023.
//

import Foundation
import UIKit

//MARK: Model for cell

struct CoinModel {
    
    let image: UIImage
    var name: String
    var rate: String
    var usd: String
}

//MARK: Model for Api

struct rateStruct: Codable {
    var rate: Double
    var asset_id_quote: String
    var asset_id_base: String
}

struct CoinApiModel {
    var rate: Double
    var asset_id_quote: String
    var asset_id_base: String
    var rateFinished: String {
        String(format: "%.2f", rate)
    }
}

