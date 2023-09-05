//
//  ProfileViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 11.08.2023.
//

import Foundation
import FirebaseAuth

final class ProfileViewModel :FavouritesViewModelProtocol{
    
    var email: String = ""
    var delegate: FavouritesViewModelDelegate? = nil
    var numberOfRows: Int {
        return self.result.count
    }
    var result: [GetDataModel] = []
    var product: [DatabaseModel] = []
    var coin: [GetDataModel] = []
    
    
    func userInfo() -> String {
        
        if Auth.auth().currentUser != nil {
            self.email = Auth.auth().currentUser?.email ?? ""
        }
       
        return self.email
    }
}
