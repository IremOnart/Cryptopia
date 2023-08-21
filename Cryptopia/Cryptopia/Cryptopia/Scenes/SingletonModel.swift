//
//  SingletonModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 17.08.2023.
//

import Foundation

class SingletonModel {
    
    static let sharedInstance = SingletonModel()
    
    var productId = ""
    
    private init(){}
}
