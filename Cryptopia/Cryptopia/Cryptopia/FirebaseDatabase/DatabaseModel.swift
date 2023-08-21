//
//  DatabaseModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 21.08.2023.
//

import Foundation

struct DatabaseModel: Identifiable, Codable {
    var id: String?
    var name: String
    var email: String
    var profilePictureURL: String
    var favoriteCoinList: [String]
}
