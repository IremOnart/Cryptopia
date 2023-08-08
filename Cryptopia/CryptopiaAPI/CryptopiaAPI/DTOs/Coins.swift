//
//  Coins.swift
//  CryptopiaAPI
//
//  Created by İrem Onart on 25.07.2023.
//

import Foundation

public struct Coins: Decodable{
    public let coins: [Coin]
}

public struct Coin: Decodable {
    public let id: String?
    public let icon: String?
    public let name: String?
    public let symbol: String?
    public let rank: Int?
    public let price: Double?
    public let priceBtc: Double?
    public let volume: Double?
    public let marketCap: Double?
    public let availableSupply: Double?
    public let totalSupply: Double?
    public let priceChange1h: Double?
    public let priceChange1d: Double?
    public let priceChange1w: Double?
    
}

public struct Charts : Decodable{
    public let chart: [[Double]]?
}
