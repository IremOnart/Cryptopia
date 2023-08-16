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
    let db = Firestore.firestore()
    var list = [FavouritesModel]()
    var numberOfRows: Int {
        return self.list.count
    }

    func fetchData() {
        
        list.removeAll()
        
        db.collection("users").getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                for document in querySnapshot!.documents {
                    
                    let model = FavouritesModel(coinID: document.data()["coinId"] as? String ?? "null" ,name: document.data()["name"] as? String ?? "null", symbol: document.data()["symbol"] as? String ?? "null", price: document.data()["price"] as? Double ?? 0, priceChange: document.data()["priceChange"] as? Double ?? 0)
                    self.list.append(model)
                    
                }
                self.delegate?.coinListFetch()
                print(self.list)
            }
        }
    }
    
    func getData(for indexPath: IndexPath) -> FavouritesModel {
        return list[indexPath.row]
    }
}
