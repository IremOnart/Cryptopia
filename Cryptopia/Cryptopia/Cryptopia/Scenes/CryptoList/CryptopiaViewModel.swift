//
//  CryptopiaViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.07.2023.
//

import CryptopiaAPI
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

final class  CryptopiaViewModel: CryptopiaViewModelProtocol{
    var onCoinsUpdated: (()->Void)?
    
    var delegate: CryptopiaViewModelDelegate?
    var numberOfRows: Int {
        return allCoins.count
    }
    
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    private var allCoins: [Coin] = [] {
        didSet{
            self.onCoinsUpdated?()
            delegate?.coinListFetch()
        }
    }
    var filteredCoins: [Coin] = []{
        didSet{
            self.onCoinsUpdated?()
            delegate?.coinListFetch()
        }
    }
    
    func getData() {
        service.fetchTopCoins(){ [weak self] (result) in
            
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
    public func inSearchModel(_ searchController: UISearchController) -> Bool{
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?){
        self.filteredCoins = allCoins
        
        if let searchText = searchBarText?.lowercased(){
            guard !searchText.isEmpty else {
                self.onCoinsUpdated?(); return
            }
            
            self.filteredCoins = self.filteredCoins.filter({ $0.name!.lowercased().contains(searchText) })
        }
        self.onCoinsUpdated?()
    }
}
