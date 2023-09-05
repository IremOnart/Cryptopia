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

final class CryptopiaViewModel: CryptopiaViewModelProtocol{
    
    var onCoinsUpdated: (()->Void)?
    var delegate: CryptopiaViewModelDelegate?
    var numberOfRows: Int {
        return product.count
    }
    var product: [GetDataModel] = []
    let service: TopCrytopiaProtocol = TopCrytopiaService()
    private var allCoins: [Coin] = [] {
        didSet{
            self.onCoinsUpdated?()
            delegate?.coinListFetch()
        }
    }
    var filteredCoins: [GetDataModel] = []{
        didSet{
            self.onCoinsUpdated?()
            delegate?.coinListFetch()
        }
    }
    
    func getData() {
        service.fetchTopCoins(){ [weak self] (result) in
            guard let self = self else { return }
            self.allCoins = result.coins
            for h in self.allCoins {
                let coinDatas = ["id": h.id ?? "", "icon": h.icon ?? "", "name": h.name ?? "", "symbol": h.symbol ?? "", "rank": h.rank ?? 0, "price": h.price ?? 0, "priceBtc": h.priceBtc ?? 0, "volume": h.volume ?? 0, "marketCap": h.marketCap ?? 0, "availableSupply": h.availableSupply ?? 0, "totalSupply": h.totalSupply ?? 0, "priceChange1h": h.priceChange1h ?? 0, "priceChange1d": h.priceChange1d ?? 0, "priceChange1w": h.priceChange1w ?? 0] as [String:Any]
                Firestore.firestore().collection("coins").document(h.id ?? "").setData(coinDatas)
            }
        }
    }
    
    func getCoinsDetails(){
        Database.shared.getCoinsDetails(completion: { products, error in
            if let error = error {
                print(error)
            } else {
                guard let products = products else {
                    return
                }
                self.product = products
                self.delegate?.coinListFetch()
                SingletonModel.sharedInstance.sharedProducts = self.product
                print(SingletonModel.sharedInstance.sharedProducts)
            }
        })
    }
    
    
    func getCoin(for indexPath: IndexPath) -> GetDataModel {
        return product[indexPath.row]
    }
    
   
}

extension CryptopiaViewModel {
    public func inSearchModel(_ searchController: UISearchController) -> Bool{
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?){
        self.filteredCoins = product
        
        if let searchText = searchBarText?.lowercased(){
            guard !searchText.isEmpty else {
                self.onCoinsUpdated?(); return
            }
            
            self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText) })
        }
        self.onCoinsUpdated?()
    }
}
