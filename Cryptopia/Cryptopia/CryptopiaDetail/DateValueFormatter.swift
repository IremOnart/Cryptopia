//
//  DateValueFormatter.swift
//  Cryptopia
//
//  Created by İrem Onart on 4.08.2023.
//

import Foundation
import DGCharts

public class DateValueFormatter: NSObject, AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    override init() {
            super.init()
            dateFormatter.dateFormat = "dd MMM yy"
        }
    public func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}
