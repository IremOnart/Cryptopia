//
//  CryptopiaDetailContracts.swift
//  Cryptopia
//
//  Created by İrem Onart on 31.07.2023.
//

import Foundation
import CryptopiaAPI
import DGCharts

protocol CryptopiaDetailViewModelProtocol {
    var coin: GetDataModel { get }
    var delegate: CryptopiaDetailViewModelDelegate { get set }
    var coinChartsX : [Double] { get set }
    var coinChartsY : [Double] { get set }
    var getTimeFromSegmentedControl: String { get set }
    func getData()
}

protocol CryptopiaDetailViewModelDelegate{
    func didCoinDetailFetched()
    func didPeriodChanged()
    func didFavAdded()
    func didFavDeleted()
}
