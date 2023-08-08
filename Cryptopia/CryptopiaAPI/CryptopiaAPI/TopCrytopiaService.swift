//
//  TopCrytopiaService.swift
//  CryptopiaAPI
//
//  Created by İrem Onart on 25.07.2023.
//

import Foundation
import UIKit

public protocol TopCrytopiaProtocol {
    func fetchTopCoins(completion: @escaping(Coins) -> Void)
    func fetchTopCharts(id: String, period: String, completion: @escaping(Charts) -> Void)
}

public class TopCrytopiaService: TopCrytopiaProtocol{
    
    public init() {}
    
    public func fetchTopCoins(completion: @escaping (Coins) -> Void) {
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")!
        URLSession.shared.dataTask(with: url) { (data, _ , error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data{
                do {
                    let coins = try JSONDecoder().decode(Coins.self, from: data)
                    completion(coins)
                } catch {
                    print("fatal error")
                }
                
                
                
            }
        }.resume()
    }
    
    public func fetchTopCharts(id: String, period: String, completion: @escaping (Charts) -> Void) {
        let url = URL(string: "https://api.coinstats.app/public/v1/charts?period=\(period)&coinId=\(id)")!
        URLSession.shared.dataTask(with: url) { (data, _ , error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data{
                do {
                    let coinsCharts = try JSONDecoder().decode(Charts.self, from: data)
                    completion(coinsCharts)
                } catch {
                    print("fatal error")
                }
                
                
            }
               
        }.resume()
    }
    
}
