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
    let icon: String
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
        self.id = coin.id ?? ""
        self.icon = coin.icon ?? ""
        self.name = coin.name ?? ""
        self.symbol = coin.symbol ?? ""
        self.rank = coin.rank ?? 0
        self.price = coin.price ?? 0.0
        self.priceBtc = coin.priceBtc ?? 0.0
        self.volume = coin.volume ?? 0.0
        self.marketCap = coin.marketCap ?? 0.0
        self.availableSupply = coin.availableSupply ?? 0.0
        self.totalSupply = coin.totalSupply ?? 0.0
        self.priceChange1h = coin.priceChange1d ?? 0.0
        self.priceChange1d = coin.priceChange1h ?? 0.0
        self.priceChange1w = coin.priceChange1w ?? 0.0
    }
}
