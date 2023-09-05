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
    let coin: GetDataModel
    var coinChartsX = [Double]()
    var coinChartsY = [Double]()
    var nsTime = [NSDate]()
    var getTimeFromSegmentedControl: String = "24h"{
        didSet{
            delegate?.didPeriodChanged()
        }
    }
    
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    init(coin: GetDataModel) {
            self.coin = coin
    }

    func getData(){
        service.fetchTopCharts(id: coin.id.lowercased() , period: getTimeFromSegmentedControl ){  [weak self] (result) in
            guard let self = self else { return }
            coinChartsX.removeAll()
            coinChartsY.removeAll()
            for group in result.chart ?? [] {
//                print(GeneralUtils.dateFromString(group[0]).timeIntervalSinceNow)
                print(NSDate(timeIntervalSince1970: 1691049600.0))
                //Int(truncating: NSDate(timeIntervalSince1970: 1691066100.0) as NSNumber);)
                self.coinChartsX.append(group[0])
                self.coinChartsY.append(group[2])
            }
            print(self.coinChartsX as Any, "+", self.coinChartsY as Any)
            self.delegate?.didCoinDetailFetched()
            }
        }
    
    func addToFavorite(coin: GetDataModel) {
        Database.shared.addToFavourites(coin: coin) { error in
            if let error = error {
                print(error)
            } else{
                self.delegate?.didFavAdded()
                print("success")
            }
        }
    }
    
    func deleteFromFavorite(coin: GetDataModel) {
        Database.shared.deleteFromFavourites(coin: coin) { error in
            if let error = error {
                print(error)
            } else{
                self.delegate?.didFavDeleted()
                print("success")
            }
        }
    }
    
     var chartData: ChartData {
        var yValues = [ChartDataEntry]()
        for i in 0..<coinChartsX.count{
            yValues.append(ChartDataEntry(x: coinChartsX[i], y: coinChartsY[i]))
        }
        let set1 = LineChartDataSet(entries: yValues, label: "CoinGraphic")
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.systemBlue)
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        return data

    }
    
}
