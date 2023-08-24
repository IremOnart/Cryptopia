//
//  FavouritesViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 14.08.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import CryptopiaAPI
import FirebaseDatabase
import FirebaseFirestoreSwift

class FavouritesViewModel: ObservableObject , FavouritesViewModelProtocol {
    
    var delegate: FavouritesViewModelDelegate? = nil
    var numberOfRows: Int {
        return self.result.count
    }
    var result: [GetDataModel] = []
    var product: [DatabaseModel] = []
    var coin: [GetDataModel] = []
    
    func getFavoriteId() {
        Database.shared.getUserInfos { userInfos, error in
            if let error = error {
                print(error)
            } else {
                guard let userInfos = userInfos else {
                    return
                }
//                self.product.removeAll()
                self.product = userInfos
                SingletonModel.sharedInstance.userInfos = self.product
                print(SingletonModel.sharedInstance.userInfos)
//                for idName in SingletonModel.sharedInstance.userInfos {
//                    SingletonModel.sharedInstance.favoriteCoinIDs.append(contentsOf: idName.favoriteCoinList)
//                }
                print(SingletonModel.sharedInstance.favoriteCoinIDs)
                self.delegate?.coinListFetch()
                self.filterForFavorite()
            }
            
            
        }
        
    }
    func filterForFavorite() {
        let favId = SingletonModel.sharedInstance.favoriteCoinIDs
        print(favId)
        for favCoin in favId {
            self.result = SingletonModel.sharedInstance.sharedProducts.filter { $0.id.contains(favCoin) }
        }
        print(self.result)
    }
    
    func getData(for indexPath: IndexPath) -> GetDataModel {
        let favId = SingletonModel.sharedInstance.favoriteCoinIDs
        print(favId)
        for favCoin in favId {
            self.result = SingletonModel.sharedInstance.sharedProducts.filter { $0.id.contains(favCoin) }
            
        }
        print(self.result)
        return self.result[indexPath.row]
    }
    
}
