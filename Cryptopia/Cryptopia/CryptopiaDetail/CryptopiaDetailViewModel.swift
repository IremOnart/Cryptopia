//
//  CryptopiaDetailViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 31.07.2023.
//

import Foundation
import CryptopiaAPI
import DGCharts

class CryptopiaDetailViewModel {
    
    var delegate: CryptopiaDetailViewModelDelegate?
    let coin: Coin
    var coinChartsX = [Double]()
    var coinChartsY = [Double]()
    
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    init(coin: Coin) {
            self.coin = coin
    }

    func getData(){
        service.fetchTopCharts(){  [weak self] (result) in
            guard let self = self else { return }
            for group in result.chart ?? [] {
                print(NSDate(timeIntervalSinceReferenceDate: group[0]))
                self.coinChartsX.append(group[0])
                self.coinChartsY.append(group[2])
            }
            print(self.coinChartsX as Any, "+", self.coinChartsY as Any)
            self.delegate?.didCoinDetailFetched()

            }
        }
    
    func getChartData() -> (ChartData) {
        var yValues = [ChartDataEntry]()
        for i in 0..<coinChartsX.count{
            yValues.append(ChartDataEntry(x: coinChartsX[i], y: coinChartsY[i]))
        }
        let set1 = LineChartDataSet(entries: yValues, label: "CoinGraphic")
        return LineChartData(dataSet: set1)

    }
    
}
