//
//  FavouritesModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 15.08.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct FavouritesModel: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var coinID: String
    var name: String
    var symbol: String
    var price: Double
    var priceChange: Double
    
    
}
