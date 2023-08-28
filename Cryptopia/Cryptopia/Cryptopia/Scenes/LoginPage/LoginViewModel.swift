//
//  LoginViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 9.08.2023.
//

import FirebaseAuth
import UIKit

class LoginViewModel {
    var product: [GetDataModel] = []
    
    func getCoinsDetails(){
        Database.shared.getCoinsDetails(completion: { products, error in
            if let error = error {
                print(error)
            } else {
                guard let products = products else {
                    return
                }
                self.product = products
                SingletonModel.sharedInstance.sharedProducts = self.product
                print(SingletonModel.sharedInstance.sharedProducts)
            }
        })
    }
    
    
    
}
