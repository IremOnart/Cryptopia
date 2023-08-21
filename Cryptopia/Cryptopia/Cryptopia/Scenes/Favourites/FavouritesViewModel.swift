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
    
    private let userCollection = Firestore.firestore().collection("users")
    
    func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
    }
    func userFavouriteProductCollection(userId: String) -> CollectionReference{
        userDocument(userId: userId).collection("favourite_products")
    }
    func userFavouriteProductDocument(userId: String, favouriteProductId: String) -> DocumentReference {
        userFavouriteProductCollection(userId: userId).document(favouriteProductId)
    }
    
    func fetchData() {
    
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userID).collection("favourite_products").getDocuments
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                self.list.removeAll()
                for document in querySnapshot!.documents {
                
                    let model = FavouritesModel(icon: document.data()["icon"] as? String ?? "null", name: document.data()["name"] as? String ?? "null", symbol: document.data()["symbol"] as? String ?? "null", rank: 0, price: document.data()["price"] as? Double ?? 0, priceBtc: 0, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: document.data()["priceChange"] as? Double ?? 0, priceChange1d: 0, priceChange1w: 0)
                    
//                    let model = FavouritesModel(icon: "", name: document.data()["name"] as? String ?? "null", coinId: document.data()["coinId"] as? String ?? "null", symbol: document.data()["symbol"] as? String ?? "null", price: document.data()["price"] as? Double ?? 0, rand: 0, priceBtc: 0, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: document.data()["priceChange"] as? Double ?? 0, priceChange1d: 0, priceChange1w: 0)
                    
//                    FavouritesModel(id: document.documentID ,coinId: document.data()["coinId"] as? String ?? "null" ,name: document.data()["name"] as? String ?? "null", symbol: document.data()["symbol"] as? String ?? "null", price: document.data()["price"] as? Double ?? 0, priceChange: document.data()["priceChange"] as? Double ?? 0)
                    
                    self.list.append(model)
                    let placeModel = SingletonModel.sharedInstance
//                    placeModel.productId.append(document.data()["coinId"] as! String)
                    print(placeModel.productId)
                }
                self.delegate?.coinListFetch()
                print(self.list)
            }
        }
        
        
        
        
    }
//    func getAllUserFavProds(userId: String) async throws -> [FavouritesModel] {
//        try await userFavouriteProductCollection(userId: userId).getDocuments(as: Fav)
//    }

    func getData(for indexPath: IndexPath) -> FavouritesModel {
        return list[indexPath.row]
    }
}
