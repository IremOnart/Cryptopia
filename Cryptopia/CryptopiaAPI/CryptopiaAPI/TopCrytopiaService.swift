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
    func fetchTopNews(completion: @escaping (News) -> Void)
}

public class TopCrytopiaService: TopCrytopiaProtocol{
    
    public init() {}
    
    public func fetchTopCoins(completion: @escaping (Coins) -> Void) {
        let url = URL(string: "https://api.coinstats.app/public/v1/coins")!
        URLSession.shared.dataTask(with: url) { (data, _ , error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data{
                let coins = try? JSONDecoder().decode(Coins.self, from: data)
                print(coins as Any)
                if let coins = coins{
                completion(coins)
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
                let coinsCharts = try? JSONDecoder().decode(Charts.self, from: data)
                print(coinsCharts as Any)
                if let coins = coinsCharts{
                completion(coins)
                }
            }
               
        }.resume()
    }
    
    public func fetchTopNews(completion: @escaping (News) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=c4518c8a1dfd4e0a8279b5d02f566faa")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data {
                do {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    print(result)
                    completion(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
}
