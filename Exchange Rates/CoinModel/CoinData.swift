//
//  CoinData.swift
//  Exchange Rates
//
//  Created by sidzhe on 01.05.2023.
//

import Foundation

//MARK: Data for Cell

class CoinData {
    
    static let shared = CoinData()
    
    var model = [
        CoinModel(image: Constants.Images.bitcoin, name: "BTC", rate: "...", usd: "USD"),
        CoinModel(image: Constants.Images.happy, name: "DOG", rate: "...", usd: "USD"),
        CoinModel(image: Constants.Images.ethereum, name: "ETH", rate: "...", usd: "USD"),
        CoinModel(image: Constants.Images.litecoin, name: "LTC", rate: "...", usd: "USD")
        
    ]
}
