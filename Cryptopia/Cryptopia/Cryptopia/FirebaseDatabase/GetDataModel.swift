//
//  GetDataModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 21.08.2023.
//

import Foundation

struct GetDataModel: Identifiable, Codable{
    var id: String?
    var icon: String
    var name: String
    var symbol: String
    var rank: String
    var price: Double
    var priceBtc: String
    var volume: String
    var marketCap: String
    var availableSupply: String
    var totalSupply: String
    var priceChange1h: String
    var priceChange1d: Double
    var priceChange1w: String
}
