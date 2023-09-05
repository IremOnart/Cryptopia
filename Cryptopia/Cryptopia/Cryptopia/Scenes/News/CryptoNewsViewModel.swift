//
//  CryptoNewsViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 25.08.2023.
//

import Foundation
import CryptopiaAPI

class CryptoNewsViewModel: CryptoNewsViewModelProtocol{
    
    var delegate: CryptoNewsViewModelDelegate?
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    var products: [New] = [] {
        didSet{
            delegate?.newListFetch()
        }
    }
    var numberOfRows: Int {
            return products.count
        }
    
    func getNewsData() {
        service.fetchTopNews(url: ENV.New_API) { [weak self] (result) in
            guard let self = self else { return }
            self.products = result.articles
        }
    }
    
    func getCoin(for indexPath: IndexPath) -> New {
            return products[indexPath.row]
        }
}
