//
//  CryptopiaViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import CryptopiaAPI

final class  CryptopiaViewModel: CryptopiaViewModelProtocol{

    var delegate: CryptopiaViewModelDelegate?
    var numberOfRows: Int {
        return allCoins.count
    }
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    private var allCoins = [Coin]() {
        didSet{
            delegate?.coinListFetch()
        }
    }
    var filteredCoins = [Coin]() {
        didSet{
            delegate?.coinListFetch()
        }
    }
    func getData() {
        service.fetchTopCoins(){ [weak self] result in
        
            guard let self = self else { return }
            self.allCoins = result.coins
            
        }
    }
    func getCoin(for indexPath: IndexPath) -> Coin {
        return allCoins[indexPath.row]
    }
    
    private func notify(_ output: CryptopiaViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

extension CryptopiaViewModel {
    public func updateSearchController(searchBarText: String?){
        self.filteredCoins = allCoins
        if let searchText = searchBarText?.lowercased(){
            guard !searchText.isEmpty else {
                return
            }
            self.filteredCoins = self.filteredCoins.filter({ $0.name!.lowercased().contains(searchText) })
        }
    }
}
