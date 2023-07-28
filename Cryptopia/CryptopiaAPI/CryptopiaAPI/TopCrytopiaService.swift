//
//  TopCrytopiaService.swift
//  CryptopiaAPI
//
//  Created by İrem Onart on 25.07.2023.
//

import Foundation

public protocol TopCrytopiaProtocol {
    func fetchTopCoins(completion: @escaping(Coins) -> Void)
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
    
}

