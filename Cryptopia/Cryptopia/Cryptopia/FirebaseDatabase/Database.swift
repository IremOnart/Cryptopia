//
//  Database.swift
//  Cryptopia
//
//  Created by İrem Onart on 21.08.2023.
//

import Foundation
import CryptopiaAPI
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class Database {
    
    let db = Firestore.firestore()
    var favouriteCoins = [String]()
    var coinsModel = GetDataModel(icon: "", name: "", symbol: "", rank: "", price: .zero, priceBtc: "", volume: "", marketCap: "", availableSupply: "", totalSupply: "", priceChange1h: "", priceChange1d: .zero, priceChange1w: "")
    var userInfoModel = DatabaseModel(name: "", email: "", profilePictureURL: "", favoriteCoinList: [""])
    func signUp(name: String, email: String, password: String, confirmPassword: String, completion: ((Error?) -> Void)? = nil) {
        if email == "" || password == "" || confirmPassword == "" {
            completion?(AuthError.emailOrPasswordNotValid)
        }
        else if password != confirmPassword {
            completion?(AuthError.passwordAndConfirmPasswordNotMatched)
        } else if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    let userData = ["username": name, "email": email, "favourites": [String](), "nativeUser": true] as [String:Any]
                    self.db.collection("users").document(userID).setData(userData) { error in
                        if let error {
                            print(error.localizedDescription)}
                        else {
                            print("User info saved.")
                        }
                    }
                    completion?(nil)
                } else {
                    completion?(error)
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completion: ((Error?) -> Void)? = nil) {
        if email == "" || password == "" {
            completion?(AuthError.emailOrPasswordNotValid)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    completion?(nil)
                } else {
                    completion?(error)
                }
            }
        }
        
    }
    
    func userInfoReferance (userID: String) -> DocumentReference {
        db.collection("users").document(userID)
    }
    
    func getCoinsDetails() -> GetDataModel {
        db.collection("coins").document().getDocument(completion: { documentSnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.coinsModel = GetDataModel(icon: documentSnapshot?.data()?["icon"] as! String, name: documentSnapshot?.data()?["name"] as! String, symbol: documentSnapshot?.data()?["symbol"] as! String, rank: documentSnapshot?.data()?["rank"] as! String, price: documentSnapshot?.data()?["price"] as! Double, priceBtc: documentSnapshot?.data()?["priceBtc"] as! String, volume: documentSnapshot?.data()?["volume"] as! String, marketCap: documentSnapshot?.data()?["marketCap"] as! String, availableSupply: documentSnapshot?.data()?["availableSupply"] as! String, totalSupply: documentSnapshot?.data()?["totalSupply"] as! String, priceChange1h: documentSnapshot?.data()?["priceChange1h"] as! String, priceChange1d: documentSnapshot?.data()?["priceChange1d"] as! Double, priceChange1w: documentSnapshot?.data()?["priceChange1w"] as! String)
//                ["icon": documentSnapshot?.data()?["icon"] as! String, "name": documentSnapshot?.data()?["name"] as! String, "symbol": documentSnapshot?.data()?["symbol"] as! String, "rank": documentSnapshot?.data()?["rank"] as! String, "price": documentSnapshot?.data()?["price"] as! String, "priceBtc": documentSnapshot?.data()?["priceBtc"] as! String, "volume": documentSnapshot?.data()?["volume"] as! String, "marketCap": documentSnapshot?.data()?["marketCap"] as! String, "availableSupply": documentSnapshot?.data()?["availableSupply"] as! String, "totalSupply": documentSnapshot?.data()?["totalSupply"] as! String, "priceChange1h": documentSnapshot?.data()?["priceChange1h"] as! String, "priceChange1d": documentSnapshot?.data()?["priceChange1d"] as! String, "priceChange1w": documentSnapshot?.data()?["priceChange1w"] as! String]
                
            }
        })
        return self.coinsModel
    }
    
    func getUserInfos() -> DatabaseModel {
        let userID = Auth.auth().currentUser?.uid ?? ""
        userInfoReferance(userID: userID).getDocument(completion: { documentSnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.userInfoModel = DatabaseModel(name: documentSnapshot?.data()?["name"] as! String , email: documentSnapshot?.data()?["email"] as! String , profilePictureURL: documentSnapshot?.data()?["profilePictureURL"] as! String , favoriteCoinList: documentSnapshot?.data()?["favoriteCoinList"] as! [String] )
                
            }
        })
        
        return userInfoModel
    }
    
    func addToFavourites(coin: GetDataModel, completion: ((Error?) -> Void)? = nil) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        favouriteCoins.append(coin.id ?? "")
        self.db.collection("users").document(userID).collection("favoriteCoinList").document(coin.id ?? "").updateData(["favourites" : favouriteCoins]) { error in
            if error == nil {
                completion?(nil)
            } else {
                completion?(error)
            }
        }
    }
    
    func deleteFromFavourites(coin: GetDataModel, completion: ((Error?) -> Void)? = nil) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        favouriteCoins = favouriteCoins.filter { $0 != coin.id }
        self.db.collection("users").document(userID).collection("favoriteCoinList").document(coin.id ?? "").updateData(["favourites" : favouriteCoins]) { error in
            if error == nil {
                completion?(nil)
            } else {
                completion?(error)
            }
        }
    }
}
