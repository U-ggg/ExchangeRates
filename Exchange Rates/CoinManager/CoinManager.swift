//
//  CoinManager.swift
//  Exchange Rates
//
//  Created by sidzhe on 02.05.2023.
//

import Foundation

struct CoinManager {
    
    var delegate: CoinDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    private let baseURL = [
        "https://rest.coinapi.io/v1/exchangerate/BTC/",
        "https://rest.coinapi.io/v1/exchangerate/ETH/",
        "https://rest.coinapi.io/v1/exchangerate/LTC/",
        "https://rest.coinapi.io/v1/exchangerate/DOGE/"
    ]
    
    private let apiKey = "<Your api key>"
    
    //MARK: URLRequest methods
    
    func checkValue(_ nameValue: String) {
        let dispatchGroup = DispatchGroup()
        var array = [CoinApiModel]()
        for i in 0...3 {
            dispatchGroup.enter()
            let url = "\(baseURL[i])\(nameValue)?apikey=\(apiKey)"
            guard let url = URL(string: url) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailError(error!)
                    return
                }
                guard let data = data else { return }
                guard let rate = parseJSON(data) else { return }
                array.append(CoinApiModel(rate: rate.rate, asset_id_quote: rate.asset_id_quote, asset_id_base: rate.asset_id_base))
                dispatchGroup.leave()
            }
            task.resume()
        }
        dispatchGroup.notify(queue: .main) {
            array.sort {$0.asset_id_base < $1.asset_id_base}
            delegate?.setCoin(array)
        }
    }
    
    func parseJSON(_ data: Data) -> CoinApiModel? {
        let decode = JSONDecoder()
        do {
            let data = try decode.decode(rateStruct.self, from: data)
            let name = data.asset_id_quote
            let rate = data.rate
            let crypto = data.asset_id_base
            return CoinApiModel(rate: rate, asset_id_quote: name, asset_id_base: crypto)
        } catch {
            delegate?.didFailError(error)
            return nil
        }
    }
}

//MARK: Protocol CoinDelegate

protocol CoinDelegate {
    func setCoin(_ coinAipModel: [CoinApiModel])
    func didFailError(_ error: Error)
}
