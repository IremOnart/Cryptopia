//
//  CoinsPresentation.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import Foundation
import UIKit
import CryptopiaAPI

struct CoinsPresentation {
    
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
    
    
    
    init(coin: Coin){
        self.id = coin.id
        self.icon = coin.icon
        self.name = coin.name
        self.symbol = coin.symbol
        self.rank = coin.rank
        self.price = coin.price
        self.priceBtc = coin.priceBtc
        self.volume = coin.volume
        self.marketCap = coin.marketCap
        self.availableSupply = coin.availableSupply
        self.totalSupply = coin.totalSupply
        self.priceChange1h = coin.priceChange1d
        self.priceChange1d = coin.priceChange1h
        self.priceChange1w = coin.priceChange1w
    }
}
