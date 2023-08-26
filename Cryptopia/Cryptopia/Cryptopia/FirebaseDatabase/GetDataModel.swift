//
//  GetDataModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 21.08.2023.
//

import Foundation

struct GetDataModel: Identifiable, Codable{
    var id: String
    var icon: String
    var name: String
    var symbol: String
    var rank: Double
    var price: Double
    var priceBtc: Double
    var volume: Double
    var marketCap: Double
    var availableSupply: Double
    var totalSupply: Double
    var priceChange1h: Double
    var priceChange1d: Double
    var priceChange1w: Double
 
}
