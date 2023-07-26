//
//  CryptopiaViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import Foundation
import CryptopiaAPI

class  CryptopiaViewModel: CryptopiaViewModelProtocol{
    
    var delegate: CryptopiaViewModelDelegate?
    var numberOfRows: Int {
        return coinsList.count
    }
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    private var coinsList: [Coin] = [] {
        didSet{
            delegate?.coinListFetch()
        }
    }
    var filteredCoins: [Coin] = []
    
    func getData() {
        service.fetchTopCoins(){ [weak self] (result) in
        
            guard let self = self else { return }
            self.coinsList = result.coins
            
            
            
        }
    }
    func getCoin(for indexPath: IndexPath) -> Coin {
        return coinsList[indexPath.row]
    }
    
    private func notify(_ output: CryptopiaViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
