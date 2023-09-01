//
//  FavoutesPageViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 26.08.2023.
//
import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import CryptopiaAPI
import FirebaseDatabase
import FirebaseFirestoreSwift

class FavoutesPageViewModel: ObservableObject , FavouritesViewModelProtocol {
    
    var delegate: FavouritesViewModelDelegate? = nil
    var numberOfRows: Int {
        return self.result.count
    }
    var result: [GetDataModel] = []
    var product: [DatabaseModel] = [] {
        didSet {
            self.delegate?.coinListFetch()
        }
    }
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
        result.removeAll()
        let favId = SingletonModel.sharedInstance.favoriteCoinIDs
        print(favId)
        for favCoin in favId {
            for idCoin in SingletonModel.sharedInstance.sharedProducts {
                if favCoin == idCoin.id {
                    self.result.append(idCoin)
                }
            }
        }
        print(result)

    }
    
    func getData(for indexPath: IndexPath) -> GetDataModel {
        return self.result[indexPath.row]
    }
    
    func deleteFromFavorite(coin: GetDataModel) {
        Database.shared.deleteFromFavourites(coin: coin) { error in
            if let error = error {
                print(error)
            } else{
                self.delegate?.coinListFetch()
                print("success")
            }
        }
    }
    
}
