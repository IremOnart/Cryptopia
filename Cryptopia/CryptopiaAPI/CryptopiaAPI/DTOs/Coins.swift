//
//  Coins.swift
//  CryptopiaAPI
//
//  Created by İrem Onart on 25.07.2023.
//

import Foundation

public struct Coins: Decodable {
    public let coins: [Coin]
}

public struct Coin: Decodable {
    let id: String
    let icon: URL
    let name: String
    let symbol: String
    let rank: Int
    let price: Double
    let priceBtc: Double
    let volume: Double
    let marketCap: Double
    let availableSupply: Double
    let totalSupply: Double
    let priceChange1h: Double
    let priceChange1d: Double
    let priceChange1w: Double

}
