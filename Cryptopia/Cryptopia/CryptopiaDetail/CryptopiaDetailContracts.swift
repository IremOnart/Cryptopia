//
//  CryptopiaDetailContracts.swift
//  Cryptopia
//
//  Created by İrem Onart on 31.07.2023.
//

import Foundation
import CryptopiaAPI

protocol CryptopiaDetailViewModelProtocol {
    var coin: Coin { get }
    var coinChartsX : [Double] { get set }
    var coinChartsY : [Double] { get set }
    init(_ coin: Coin)
    func getData()
}

protocol CryptopiaDetailViewModelDelegate{
    func didCoinDetailFetched()
}
