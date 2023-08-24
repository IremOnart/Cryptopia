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
    
    static let shared = Database()
    private init(){}
    
    let db = Firestore.firestore()
    var favouriteCoins = [String]()
    //    var coinsModel = GetDataModel(icon: "", name: "", symbol: "", rank: 0, price: .zero, priceBtc: 0, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: 0, priceChange1d: .zero, priceChange1w: 0)
    //    var userInfoModel = DatabaseModel(name: "", email: "", profilePictureURL: "", favoriteCoinList: [""])
    
    func signUp(name: String, email: String, password: String, confirmPassword: String, completion: @escaping (Error?) -> Void) {
        if email == "" || password == "" || confirmPassword == "" {
            completion(AuthError.emailOrPasswordNotValid)
        }
        else if password != confirmPassword {
            completion(AuthError.passwordAndConfirmPasswordNotMatched)
        } else if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    let userData = ["username": name, "email": email, "favoriteCoinList": [String](), "nativeUser": true, "profilePictureURL" : String()] as [String:Any]
                    self.db.collection("users").document(userID).setData(userData) { error in
                        if let error {
                            print(error.localizedDescription)}
                        else {
                            print("User info saved.")
                        }
                    }
                    completion(nil)
                } else {
                    completion(error)
                }
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil {
                    completion(nil)
                } else {
                    completion(error)
                }
                
            }
        
        
    }
    
    
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        if email == "" || password == "" {
            completion(AuthError.emailOrPasswordNotValid)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    completion(nil)
                } else {
                    completion(error)
                }
            }
        }
        
    }
    
    func signOut(completion: (Error?) -> Void){
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch {
            print("errorr")
            completion(error)
        }
    }
    
    func userInfoReferance (userID: String) -> DocumentReference {
        db.collection("users").document(userID)
    }
    
    let coinCollection = Firestore.firestore().collection("coins")
    
    func getCoinsDetails(completion: @escaping ([GetDataModel]?, Error?) -> Void) {
        coinCollection.getDocuments(completion: { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)");
                completion(nil, err)
            }
            else {
                var product: [GetDataModel] = []
                for document in querySnapshot!.documents {
                    let coinsModel = GetDataModel(id: document.data()["id"] as! String, icon: document.data()["icon"] as! String, name: document.data()["name"] as! String, symbol: document.data()["symbol"] as! String, rank: document.data()["rank"] as! Double, price: document.data()["price"] as! Double, priceBtc: document.data()["priceBtc"] as! Double, volume: document.data()["volume"] as! Double, marketCap: document.data()["marketCap"] as! Double, availableSupply: document.data()["availableSupply"] as! Double, totalSupply: document.data()["totalSupply"] as! Double, priceChange1h: document.data()["priceChange1h"] as! Double, priceChange1d: document.data()["priceChange1d"] as! Double, priceChange1w: document.data()["priceChange1w"] as! Double)
                    product.append(coinsModel)
                }
                completion(product, nil)
            }
        })
    }
    
    func getUserInfos(completion: @escaping ([DatabaseModel]?, Error?) -> Void) {
        let userID = Auth.auth().currentUser?.uid ?? ""
        userInfoReferance(userID: userID).getDocument(completion: { documentSnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil, err)
            } else {
                var product: [DatabaseModel] = []
                let userInfoModel = DatabaseModel(name: documentSnapshot?.data()?["username"] as! String , email: documentSnapshot?.data()?["email"] as! String , profilePictureURL: documentSnapshot?.data()?["profilePictureURL"] as! String , favoriteCoinList: documentSnapshot?.data()?["favoriteCoinList"] as! [String] )
                product.append(userInfoModel)
                completion(product, nil)
                SingletonModel.sharedInstance.favoriteCoinIDs = userInfoModel.favoriteCoinList
                SingletonModel.sharedInstance.username = userInfoModel.name
                SingletonModel.sharedInstance.email = userInfoModel.email
            }
            
            
        })
    }
    
    func addToFavourites(coin: GetDataModel, completion: @escaping (Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        favouriteCoins.append(coin.id)
        self.db.collection("users").document(userID).updateData(["favoriteCoinList": favouriteCoins]) { error in
            if error == nil {
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func deleteFromFavourites(coin: GetDataModel, completion: @escaping (Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        favouriteCoins = favouriteCoins.filter { $0 != coin.id }
        self.db.collection("users").document(userID).updateData(["favoriteCoinList" : favouriteCoins]) { error in
            if error == nil {
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
}
