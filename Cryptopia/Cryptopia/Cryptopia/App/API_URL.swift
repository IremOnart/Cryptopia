//
//  API_URL.swift
//  Cryptopia
//
//  Created by İrem Onart on 5.09.2023.
//

import Foundation

class BaseENV {
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("couldnt find file \(resourceName) plist")
        }
        self.dict = plist
    }
}

protocol APIKeyable {
    var New_API: String { get }
}

class ProdENV: BaseENV, APIKeyable {
    
    init() {
        super.init(resourceName: "PropertyList")
    }
    
    var New_API: String {
        dict.object(forKey: "News_API") as? String ?? ""
    }
}
