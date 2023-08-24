//
//  SingletonModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 17.08.2023.
//

import Foundation

class SingletonModel {
    
    static let sharedInstance = SingletonModel()
    
    var sharedProducts : [GetDataModel] = []
    var buttonLabel: String = ""
    var userInfos : [DatabaseModel] = []
    var favoriteCoinIDs : [String] = []
    var username: String = ""
    var email: String = ""
    var userPhoto: String = ""
    var product: [DatabaseModel] = []
    
    private init(){}
    
    func getUserInfos() {
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
            }
        }
    }
}
